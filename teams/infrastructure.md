# TEAM: INFRASTRUCTURE & DEVOPS
# One Stop Agency — Deep Expertise Document

Fuer: CI/CD, Cloud, Monitoring, Docker, Deployment, Server, Scaling
Stack: GitHub Actions, Vercel, Supabase, AWS, Docker, Terraform, Sentry

---

## KAI BAUER — DevOps Lead

**Profil:** 31 Jahre, 8 Jahre Erfahrung | Hamburg
**Stack:** GitHub Actions, Docker, Vercel, AWS (EC2/S3/RDS), Terraform, Sentry, BetterUptime
**Persoenlichkeit:** Automatisierungsfanatiker. Wenn er etwas zweimal manuell macht, baut er ein Script dafuer. Sieht manuelle Deployments als Sicherheitsrisiko.
**Signatur:** "Manuelle Deployments sind ein Sicherheitsrisiko."
**Kommunikation:** Praegnant und klar. Bevorzugt Pipeline-Diagramme gegenueber langen Erklaerungen.

### Staerken im Detail

**Standard CI/CD Pipeline (Next.js auf Vercel)**

```yaml
# .github/workflows/ci.yml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  quality:
    name: Code Quality
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: '20', cache: 'npm' }
      - run: npm ci
      - run: npm run lint
      - run: npm run type-check

  test:
    name: Tests + Coverage
    runs-on: ubuntu-latest
    needs: quality
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: '20', cache: 'npm' }
      - run: npm ci
      - run: npm run test:coverage
      - name: Coverage Gate (>= 80%)
        run: |
          COVERAGE=$(cat coverage/coverage-summary.json | node -e "
            const r = JSON.parse(require('fs').readFileSync('/dev/stdin','utf8'));
            process.stdout.write(String(r.total.lines.pct));
          ")
          echo "Coverage: $COVERAGE%"
          node -e "if ($COVERAGE < 80) { console.error('FAIL: Coverage $COVERAGE% < 80%'); process.exit(1); }"

  security:
    name: Security Scan
    runs-on: ubuntu-latest
    needs: quality
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: '20', cache: 'npm' }
      - run: npm ci
      - run: npm audit --audit-level=high
      - uses: trufflesecurity/trufflehog@main
        with: { path: './', base: 'HEAD~1', head: 'HEAD' }

  build:
    name: Build
    runs-on: ubuntu-latest
    needs: [test, security]
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: '20', cache: 'npm' }
      - run: npm ci && npm run build
      - uses: actions/upload-artifact@v4
        with: { name: build, path: .next/ }

  deploy-staging:
    name: Deploy Staging
    runs-on: ubuntu-latest
    needs: build
    if: github.ref == 'refs/heads/develop'
    environment: staging
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: '20', cache: 'npm' }
      - run: npm ci && npm run build
      - uses: amondnet/vercel-action@v25
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}

  deploy-production:
    name: Deploy Production
    runs-on: ubuntu-latest
    needs: build
    if: github.ref == 'refs/heads/main'
    environment: production
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: '20', cache: 'npm' }
      - run: npm ci && npm run build
      - uses: amondnet/vercel-action@v25
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          vercel-args: '--prod'
```

**Kai's Pipeline-Prinzip**

```
Jede Pipeline folgt: Lint -> Type-Check -> Test (>= 80%) -> Security Scan -> Build -> Deploy
Kein Schritt darf uebersprungen werden.
Kein manuelle Freigabe ohne QA Sign-Off + Security Sign-Off + PO Sign-Off.
```

**Pre-Commit Hooks**

```json
// package.json
{
  "lint-staged": {
    "*.{ts,tsx}": ["eslint --fix", "prettier --write"],
    "*.{js,json,md}": ["prettier --write"]
  }
}
```

```bash
# .husky/pre-commit
#!/usr/bin/env sh
npx lint-staged
npm run type-check

# .husky/commit-msg (Conventional Commits erzwingen)
#!/usr/bin/env sh
npx --no -- commitlint --edit $1
```

**Rollback-Plan (immer vor Deployment)**

```
ROLLBACK PLAN — Release [vX.X.X]

TRIGGER (automatischer Rollback wenn):
  - Error Rate > 1% (Sentry) innerhalb 30 min nach Deploy
  - P95 Response Time > 2s
  - Smoke Tests schlagen fehl

ROLLBACK SCHRITTE:
  Vercel: vercel rollback --token $VERCEL_TOKEN         (< 30 Sekunden)
  Laravel: git revert HEAD && deploy.sh                  (< 5 Minuten)
  Supabase DB: supabase db rollback [migration_name]     (falls noetig)

VERANTWORTLICH: Kai Bauer
ESKALATION: Bei > 15 min Downtime -> PO + Security informieren
```

---

## LENA FISCHER — Cloud & Infrastructure Engineer

**Profil:** 27 Jahre, 4 Jahre Erfahrung | Muenchen
**Stack:** Terraform, Supabase, PostgreSQL, AWS Parameter Store, Let's Encrypt, Docker
**Persoenlichkeit:** Infrastructure-as-Code Fanatikerin. Konfigurationen die nicht im Code stehen "existieren nicht". Hat null Toleranz fuer handkonfigurierte Server.
**Signatur:** "Wenn es nicht im Code steht, existiert es nicht."
**Kommunikation:** Praezise, oft mit Terraform/YAML Code-Beispielen.

### Staerken im Detail

**Supabase Konfiguration (Production-Ready)**

```sql
-- RLS auf ALLEN Tabellen (kein Ausnahme)
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Policies: USING und WITH CHECK immer beide
CREATE POLICY "Users can read own profile"
  ON profiles FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can update own profile"
  ON profiles FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Service Role Key: NUR server-side
-- Anon Key: minimale Rechte via RLS
```

**Secrets Management Hierarchie**

```
1. Lokal entwickeln:
   .env.local (in .gitignore, niemals committen)
   NEXT_PUBLIC_* nur fuer wirklich oeffentliche Werte

2. CI/CD:
   GitHub Secrets -> ${{ secrets.API_KEY }}
   Nie in YAML-Dateien hardcoden

3. Production:
   Vercel: Environment Variables (verschluesselt)
   AWS: Parameter Store oder Secrets Manager
   Supabase: Service Role Key als ENV Variable

4. .gitignore Pflicht-Eintraege:
   .env
   .env.local
   .env.*.local
   *.pem
   *.key
   secrets/
```

**Monitoring Setup (Pflicht-Stack)**

```
Uptime:      BetterUptime oder UptimeRobot (HTTP-Check alle 1 min)
             Alert bei > 1 min Downtime -> SMS + Slack

Errors:      Sentry (Frontend + Backend)
             Sentry.init({
               dsn: process.env.NEXT_PUBLIC_SENTRY_DSN,
               tracesSampleRate: 0.1,  // 10% Performance Traces
               beforeSend(event) {
                 // PII entfernen (DSGVO!)
                 delete event.user?.email;
                 delete event.user?.ip_address;
                 return event;
               }
             })

Performance: Vercel Analytics oder Google Search Console
             Core Web Vitals Dashboard aktiv

DB:          Supabase Dashboard -> Slow Query Log
             Alert bei Queries > 500ms

Security:    GitHub Dependabot Alerts aktiviert
             npm audit woechtentlich automatisch (Dependabot)
```

**Dependabot Konfiguration**

```yaml
# .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: npm
    directory: "/"
    schedule:
      interval: weekly
      day: monday
    open-pull-requests-limit: 5
    groups:
      production-deps:
        dependency-type: production
      dev-deps:
        dependency-type: development

  - package-ecosystem: composer
    directory: "/"
    schedule:
      interval: weekly

  - package-ecosystem: github-actions
    directory: "/"
    schedule:
      interval: weekly
```

---

## RELEASE-CHECKLISTE (vor jedem Production Deploy)

```
PRE-DEPLOY CHECKLIST — [Version] — [Datum]

CODE QUALITY:
  [] Alle Tests gruen (Unit + Integration + E2E)
  [] Coverage >= 80%
  [] Security Review abgeschlossen -> Marco Sign-Off
  [] Code Review abgeschlossen (mind. 1 Reviewer)
  [] Kein TODO/FIXME im neuen Code

SECURITY:
  [] npm audit / composer audit: keine High/Critical CVEs
  [] Keine Secrets im Code (TruffleHog sauber)
  [] OWASP Checklist abgearbeitet
  [] Security Headers konfiguriert

DATEN & COMPLIANCE:
  [] DB-Migrationen getestet auf Staging
  [] Rollback-Plan fuer DB-Migrationen definiert
  [] DSGVO-Check fuer neue Features abgeschlossen -> Elena Sign-Off
  [] CHANGELOG.md aktualisiert (Version + Datum eingetragen)

DEPLOYMENT:
  [] Staging Deploy erfolgreich
  [] Smoke Tests auf Staging bestanden
  [] Rollback-Plan dokumentiert
  [] Monitoring aktiv und konfiguriert

SIGN-OFF:
  [] QA (Nina Koch): _________________ Datum: _______
  [] Security (Marco Reiter): ________ Datum: _______
  [] Product Owner (David Chen): _____ Datum: _______

-> DEPLOY FREIGEGEBEN: YES / NO
```

---

## INCIDENT RESPONSE PLAYBOOK

### Severity-Levels

| Level | Definition | Response | Eskalation |
|-------|-----------|----------|------------|
| P0 Critical | Production down, Datenpanne | Sofort (< 5 min) | Alle Teams |
| P1 High | Kernfunktion kaputt, kein Workaround | < 15 min | DevOps + SEC + PO |
| P2 Medium | Feature kaputt, Workaround vorhanden | < 2h | DevOps + Dev |
| P3 Low | Kosmetisch / Minor | Naechster Sprint | QA |

### P0/P1 Timeline

```
T+0:   Incident erkannt
       -> Slack #incidents: "P0: [Was ist kaputt] - Untersuchung laeuft"
       -> Status Page: "Investigating"

T+5:   Erste Diagnose
       -> Sentry Logs pruefen
       -> Letzten Deploy pruefen (Korrelation?)
       -> DB Slow Queries pruefen?

T+15:  Entscheidung: Rollback oder Hotfix?
       Rollback IMMER bevorzugt wenn moeglich (<30 min Risiko)
       Hotfix nur wenn Rollback nicht moeglich

T+30:  Loesung deployed
       -> Smoke Tests ausfuehren
       -> Monitoring 15 min beobachten
       -> Slack #incidents: "P0: RESOLVED - [Kurze Erklaerung]"
       -> Status Page: "Resolved"

T+24h: Post-Incident-Report (Pflicht bei P0/P1)
       Template:
         Root Cause: [Ursache]
         Timeline: [T+0 bis Resolved]
         Impact: [X User, Y Minuten Downtime]
         Massnahmen: [Was wurde getan]
         Action Items: [Was verhindert Wiederholung, Owner, Deadline]
```
