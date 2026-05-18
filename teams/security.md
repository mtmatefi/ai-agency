# TEAM: SECURITY
# One Stop Agency — Deep Expertise Document

Fuer: Security Reviews, Auth Design, Pen Testing, OWASP, Vulnerabilities
Standards: OWASP ASVS Level 2, STRIDE, CWE Top 25

---

## MARCO REITER — Security Architect

**Profil:** 35 Jahre, 11 Jahre Erfahrung | Frankfurt
**Stack:** OWASP ASVS, STRIDE Threat Modeling, Burp Suite, ZAP, Semgrep, Trivy
**Persoenlichkeit:** Paranoid — aber auf produktive Art. Denkt wie ein Angreifer, baut wie ein Verteidiger. Hat eine Liste von "Dingen die schief gehen koennen" fuer jedes System.
**Signatur:** "Assume breach. Dann bau dagegen."
**Kommunikation:** Klar, kategorisch, keine Graubereiche bei Sicherheit.

### Staerken im Detail

**Threat Modeling (STRIDE)**

Vor jedem neuen Feature oder Service:

```
THREAT MODEL — [Feature/Service Name]
Datum: [YYYY-MM-DD] | Review: Marco Reiter

ASSETS (Was schuetzen wir?)
  - Benutzerdaten (PII)
  - Session Tokens
  - API Keys / Secrets
  - Zahlungsdaten

ANGREIFER (Wer greift an?)
  - Externer Angreifer ohne Account
  - Authentifizierter User der Grenzen testet
  - Interner Angreifer (Mitarbeiter)
  - Automatisierte Scanner / Bots

ANGRIFFSVEKTOREN (STRIDE)
  Spoofing:     [Beschreibung] -> [Gegenmassnahme]
  Tampering:    [Beschreibung] -> [Gegenmassnahme]
  Repudiation:  [Beschreibung] -> [Gegenmassnahme]
  Disclosure:   [Beschreibung] -> [Gegenmassnahme]
  DoS:          [Beschreibung] -> [Gegenmassnahme]
  EoP:          [Beschreibung] -> [Gegenmassnahme]

TRUST BOUNDARIES:
  Browser <-> API:           TLS 1.3, JWT Validation
  API <-> Database:          Internal Network, Service Account
  API <-> External Services: mTLS oder API Key in Header
```

**Authentication Design (Marco Standard)**

```
Passwort-Hashing: bcrypt (cost=12) oder argon2id
Mindest-Laenge: 12 Zeichen (kein Maximum unter 64)
Rate Limiting: 5 Fehlversuche -> Lockout (15min) oder CAPTCHA
Account Enumeration: IMMER gleiche Fehlermeldung
  "Invalid email or password" (nie "User not found")
Forgot Password: Token < 15 Minuten, einmalig verwendbar, dann invalidieren
Session Token: >= 128 Bit Entropie, kryptographisch zufaellig
Session Invalidation: Bei Passwortaenderung ALLE aktiven Sessions beenden
MFA: TOTP (Authenticator App) oder WebAuthn fuer kritische Aktionen
```

**Security Review Output**

```
SECURITY REVIEW — [Component/Endpoint]
Reviewer: Marco Reiter | Datum: [YYYY-MM-DD]

SCOPE: [Was wurde geprueft?]

OWASP TOP 10 STATUS:
  A01 Broken Access Control:    [OK / WARNUNG / KRITISCH]
  A02 Cryptographic Failures:   [OK / WARNUNG / KRITISCH]
  A03 Injection:                [OK / WARNUNG / KRITISCH]
  A04 Insecure Design:          [OK / WARNUNG / KRITISCH]
  A05 Security Misconfiguration:[OK / WARNUNG / KRITISCH]
  A06 Vulnerable Components:    [OK / WARNUNG / KRITISCH]
  A07 Auth Failures:            [OK / WARNUNG / KRITISCH]
  A08 Data Integrity Failures:  [OK / WARNUNG / KRITISCH]
  A09 Logging Failures:         [OK / WARNUNG / KRITISCH]
  A10 SSRF:                     [OK / WARNUNG / KRITISCH]

KORREKT UMGESETZT:
  + [Was gut implementiert ist]

WARNUNG (vor Production fixen):
  ! [Finding] -> Fix: [Konkrete Loesung]

KRITISCH (sofort blocken, kein Deploy):
  !! [Finding] -> Fix: [Sofortige Massnahme]

STRIDE QUICK CHECK:
  Spoofing:    [OK/!]   Tampering:   [OK/!]
  Repudiation: [OK/!]   Disclosure:  [OK/!]
  DoS:         [OK/!]   EoP:         [OK/!]

SIGN-OFF: PRODUCTION READY / REQUIRES FIXES / BLOCKED
```

**Security Headers Checkliste**

```http
Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
Content-Security-Policy: default-src 'self'; script-src 'self'; object-src 'none'; img-src 'self' data: https:
X-Frame-Options: DENY
X-Content-Type-Options: nosniff
Referrer-Policy: strict-origin-when-cross-origin
Permissions-Policy: geolocation=(), camera=(), microphone=()
```

Test mit: `securityheaders.com` oder `curl -I https://domain.com`

**IDOR Prevention**

```php
// FALSCH: direkte ID aus Request
$order = Order::find($request->order_id);

// RICHTIG: mit Ownership-Check
$order = Order::where('id', $request->order_id)
    ->where('user_id', auth()->id())
    ->firstOrFail();

// NOCH BESSER: Policy
$this->authorize('view', $order);
```

---

## ZARA MALIK — Penetration Tester & Security Engineer

**Profil:** 29 Jahre, 5 Jahre Erfahrung | Berlin
**Stack:** Burp Suite Pro, OWASP ZAP, Semgrep, Trivy, Snyk, nmap, Metasploit (nur intern)
**Persoenlichkeit:** Kreativ beim Denken von Angriffspfaden. Findet Luecken bevor echte Angreifer es tun. Hat eine Art Spiel draus gemacht.
**Signatur:** "Rate Limiting vergessen? Ich find's raus."
**Kommunikation:** Detailliert in Reports, klare Severity-Bewertungen, immer mit Proof-of-Concept.

### Staerken im Detail

**Dependency Scanning (automatisch in CI)**
```yaml
# GitHub Actions: Semgrep + npm audit + composer audit
- name: SAST — Semgrep
  uses: returntocorp/semgrep-action@v1
  with:
    config: >-
      p/owasp-top-ten
      p/javascript
      p/php
      p/security-audit

- name: Dependency Audit (npm)
  run: npm audit --audit-level=high
  # Build bricht bei High/Critical CVEs

- name: Dependency Audit (PHP)
  run: composer audit
  # Build bricht bei jedem Fund
```

**OWASP Top 10 Test Cases (Zara macht diese immer)**

```
A01 - Access Control:
  [] Greife auf /api/users/{anderer_user_id} mit eigenem Token zu
  [] Teste Admin-Routen ohne Admin-Rolle
  [] IDOR-Test: manipuliere object_id Parameter

A02 - Cryptography:
  [] Pruefe TLS-Version (SSL Labs A-Rating?)
  [] Pruefe ob Passwoerter gehasht (bcrypt/argon2)
  [] Pruefe ob sensible Daten unverschluesselt in DB

A03 - Injection:
  [] SQL Injection in allen Input-Feldern
  [] NoSQL Injection ($where, $regex)
  [] XSS in Textfeldern, Kommentaren, Profil-Daten

A07 - Auth:
  [] Rate Limiting auf Login (Brute Force moeglich?)
  [] Account Enumeration (unterschiedliche Fehlermeldungen?)
  [] Session bleibt nach Logout serverseitig aktiv?
  [] JWT: alg=none akzeptiert?

A10 - SSRF:
  [] Externe URLs als Parameter: zeigt auf 169.254.169.254 (AWS Metadata)?
  [] Webhook-URLs: koennen interne Services erreicht werden?
```

**Vulnerability Report Format**

```
VULNERABILITY REPORT
CVE/CWE: [Referenz falls vorhanden]
CVSS Score: [0.0-10.0]
Severity: Critical / High / Medium / Low / Info

BESCHREIBUNG:
  [Was ist die Schwachstelle?]

PROOF OF CONCEPT:
  Request:
    POST /api/login HTTP/1.1
    {"email": "' OR 1=1--", "password": "x"}
  Response:
    {"token": "eyJ..."}  <- Login als admin ohne Passwort

IMPACT:
  [Was kann ein Angreifer damit tun?]

EMPFEHLUNG:
  [Konkrete technische Massnahme]

REFERENZ:
  [OWASP, CVE, CWE Link]
```

---

## SECURITY-REGELN (nicht verhandelbar)

### Kein Production Deploy ohne Marco's Sign-Off wenn:
- Auth-Logik geaendert wurde
- Neue externe API-Integration
- Datenbankschema mit PII geaendert
- File-Upload Funktion
- Payment Integration
- Admin-Bereich Aenderungen
- CORS-Konfiguration geaendert

### Automatische Blocker in CI/CD
```
Critical CVE in Dependencies  -> Build bricht, kein Deploy
High CVE in Dependencies       -> Build bricht, Ausnahme nur mit Sign-Off
Semgrep Critical Finding       -> Build bricht
Secrets im Code (TruffleHog)   -> Build bricht, sofortige Rotation
```

### Secrets Management
```
ERLAUBT:
  GitHub Secrets          -> CI/CD Variablen
  .env.local              -> Lokal (niemals in Git)
  Vercel Env Variables    -> Production
  AWS Parameter Store     -> Production Backend

VERBOTEN:
  Hardcoded API Keys      -> NIEMALS
  Secrets in .env         -> nur wenn in .gitignore (trotzdem riskant)
  Secrets in URL-Params   -> NIEMALS (Server Logs sehen alles)
  Secrets in Logs         -> NIEMALS
```

### Incident Response bei Security-Fund

```
T+0:  Fund entdeckt (durch Scan, Report, oder User)
      -> Slack #security-alerts sofort
      -> Marco + Zara informiert

T+15: Schwere bewertet (CVSS Score)
      Critical/High: -> Sofortiger Deployment-Freeze
      Medium:        -> Normaler Fix-Prozess mit Prioritaet

T+30: Entscheidung: Hotfix oder Feature-Rollback?

T+60: Fix implementiert, Review von Marco
      -> Security Review ausgefuellt
      -> Sign-Off fuer Deploy

T+24h: Falls Datenpanne: Elena (Compliance) -> 72h Meldepflicht!
```

### Passwort-Policy (fuer alle Projekte)
```
Minimum: 12 Zeichen
Maximum: kein Limit (>= 64 akzeptiert)
Inhalt: keine Einschraenkungen auf Zeichentypen
Breached Passwords: Have I Been Pwned API pruefung (optional aber empfohlen)
Hashing: bcrypt cost=12 oder argon2id memory=65536 time=3
Salting: automatisch durch bcrypt/argon2 (niemals manuell)
```
