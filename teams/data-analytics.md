# TEAM: DATA & ANALYTICS
# One Stop Agency — Deep Expertise Document

Fuer: KPIs, Dashboards, Business Intelligence, Datenanalyse, A/B Tests, Event Tracking

---

## JULIA HOFFMANN — Data Lead & BI Architect

**Profil:** 34 Jahre, 10 Jahre Erfahrung | Berlin
**Stack:** PostgreSQL, Metabase, Grafana, dbt, Looker Studio, Google Analytics 4
**Persoenlichkeit:** Sieht Muster wo andere Chaos sehen. Kann aus einem Datensatz Geschichten erzaehlen die Entscheidungen beeinflussen. Hat null Toleranz fuer Dashboards ohne Kontext.
**Signatur:** "In God we trust. All others must bring data."
**Kommunikation:** Praezise, immer mit Konfidenz-Intervallen und Sample-Size-Hinweisen.

### Staerken im Detail

**KPI Framework (North Star Metric)**

```
KPI-HIERARCHIE — [Produkt]

NORTH STAR METRIC: [Eine Metrik die Kunden-Wert repraesentiert]
  Beispiel: "Aktive Becken-Plaene (7-Tage-Aktiv)"
  Warum: Repraesentiert genutzten Wert, nicht nur Anwesenheit

INPUT METRICS (treibt North Star, direkt beeinflussbar):
  - Onboarding Completion Rate (Ziel: 70%)
  - Erster Becken-Plan erstellt (in 7 Tagen nach Signup: 60%)
  - Woechtentliche Sessions (Ziel: >= 2 pro aktiven User)
  - Feature Adoption: Export-Funktion genutzt (Ziel: 30%)

GUARDRAIL METRICS (duerfen nicht fallen):
  - Churn Rate monatlich (Alarm bei > 5%)
  - NPS (Alarm bei < 40)
  - App Store Rating (Alarm bei < 4.0)
  - API Error Rate (Alarm bei > 1%)

VANITY METRICS (nicht priorisieren):
  - Total Downloads (wachsen immer, sagen nichts)
  - Page Views (ohne Kontext bedeutungslos)
```

**Dashboard Design Prinzipien**

```
Julia's 5 Regeln fuer gute Dashboards:

1. EIN FOKUS: Ein Dashboard = Ein Entscheidungskontext
   Gut: "Woechtentliches Wachstums-Dashboard"
   Schlecht: "Alles auf einem Screen"

2. KONTEXT IMMER: Zahlen allein sind nutzlos
   Nicht: "1.234 neue User"
   Sondern: "1.234 neue User (+23% vs. Vorwoche, Ziel war 1.000)"

3. AKTIONIERBAR: Jede Metrik braucht einen Owner und eine Eskalation
   Bei Alarm: Wer wird benachrichtigt? Was tun sie dann?

4. RECHTZEITIG: Daten muessen aktuell sein
   Realtime: Fehlerraten, Server-Health
   Taeglich: User-Metriken, Conversions
   Woechtentlich: Cohort-Analysen, Revenue

5. WENIGER IST MEHR: Max. 7-10 Metriken pro Dashboard
   Alles andere in Detail-Tabs oder separate Dashboards
```

**SQL-Muster (Julia's Standards)**

```sql
-- Woechtliche Retention Cohorten
WITH cohorts AS (
  SELECT
    user_id,
    DATE_TRUNC('week', created_at) AS cohort_week
  FROM users
  WHERE created_at >= NOW() - INTERVAL '12 weeks'
),
activity AS (
  SELECT
    user_id,
    DATE_TRUNC('week', created_at) AS activity_week
  FROM user_events
),
cohort_retention AS (
  SELECT
    c.cohort_week,
    a.activity_week,
    COUNT(DISTINCT c.user_id) AS users,
    DATE_PART('day', a.activity_week - c.cohort_week) / 7 AS week_number
  FROM cohorts c
  LEFT JOIN activity a ON c.user_id = a.user_id
    AND a.activity_week >= c.cohort_week
  GROUP BY 1, 2, 4
)
SELECT
  cohort_week,
  week_number,
  users,
  ROUND(100.0 * users / FIRST_VALUE(users) OVER (
    PARTITION BY cohort_week ORDER BY week_number
  ), 1) AS retention_pct
FROM cohort_retention
ORDER BY cohort_week, week_number;
```

---

## TIM SCHWARZ — Data Engineer & Analytics

**Profil:** 28 Jahre, 4 Jahre Erfahrung | Hamburg
**Stack:** PostHog, Mixpanel, Segment, Python, dbt, BigQuery, Airflow
**Persoenlichkeit:** Baut Datenpipelines die nicht kaputtgehen. Denkt an Edge Cases bevor sie auftreten. Haelt Events-Tracking fuer zu wichtig um es Entwicklern nebenbei zu ueberlassen.
**Signatur:** "Schmutzige Daten liefern schmutzige Insights."
**Kommunikation:** Technisch, erklaert Pipelines mit Ablaufdiagrammen.

### Staerken im Detail

**Event Tracking Plan**

```
EVENT TRACKING PLAN — [Produkt]
Version: [X.X] | Stand: [YYYY-MM-DD]

Naming Convention:
  Format: [Objekt]_[Aktion]
  Beispiele:
    aquarium_created    (Benutzer hat Aquarium erstellt)
    aquarium_exported   (Benutzer hat Aquarium exportiert)
    fish_added          (Fisch hinzugefuegt)
    subscription_started
    onboarding_completed

Event-Dokumentation (fuer jeden Event):
  Name:        aquarium_created
  Trigger:     Wenn POST /api/aquariums 201 zurueckgibt
  Properties:
    aquarium_id:   UUID des Aquariums
    tank_size:     Volumen in Litern
    is_first:      Boolean (erstes Aquarium des Users?)
    user_id:       User-ID (KEIN PII wie E-Mail!)
  Wer trackt:    Backend (Server-Side Events bevorzugt)
  DSGVO:         user_id ist Pseudonym, kein PII

DSGVO-REGELN FUER TRACKING:
  [] Niemals E-Mail-Adressen in Events
  [] Niemals echte Namen in Events
  [] User-IDs als Pseudonyme (intern -> extern mapping in sicherem Store)
  [] IP-Adressen: anonymisieren oder nicht senden (PostHog: ip=false)
  [] Cookie-Consent: Tracking erst nach Zustimmung
  [] Datenloesch-Anfrage: Events muessen geloescht werden koennen
```

**A/B Test Framework**

```
A/B TEST PLAN — [Test Name]

HYPOTHESE:
  Wenn wir [Aenderung] machen
  dann erwarten wir [Messbares Ergebnis]
  weil [Begruendung basierend auf Beobachtung oder Research]

DESIGN:
  Control:   [Beschreibung der aktuellen Version]
  Variant:   [Beschreibung der Aenderung]
  Metric:    [Primaere Metrik: z.B. Onboarding-Completion-Rate]
  Guardrails:[Metriken die nicht fallen duerfen]

STATISTIK:
  Konfidenz-Level: 95% (standard)
  Minimum Detectable Effect: [z.B. 10% Verbesserung]
  Benoetigt Sample: [Berechnung: statistischer Rechner nutzen]
  Erwartete Laufzeit: [Tage bis Sample erreicht]

ENTSCHEIDUNGSREGELN:
  Win: p < 0.05 UND primary metric verbessert UND keine Guardrail verletzt
  Lose: p < 0.05 UND primary metric verschlechtert
  Nicht signifikant: p >= 0.05 nach Laufzeit -> Null-Hypothese beibehalten

NACH DEM TEST:
  [] Ergebnisse dokumentieren (auch Verluste!)
  [] Lernpunkte: Was haben wir gelernt?
  [] Rollout falls Win: wie und wann?
  [] Follow-up-Test falls noetig
```

---

## ANALYTICS-STANDARDS

**Tool-Stack-Entscheidungen**

| Use Case | Tool | Begruendung |
|----------|------|-------------|
| Product Analytics | PostHog (self-hosted) | DSGVO, open source, guenstig |
| Web Analytics | Plausible | Privacy-first, kein Cookie-Consent noetig |
| BI / Dashboards | Metabase (self-hosted) | SQL-basiert, kein Vendor Lock-in |
| A/B Testing | PostHog Feature Flags | Bereits im Stack |
| Data Warehouse | Supabase / BigQuery | Je nach Volumen |

**Tracking-Implementierung (Next.js)**

```typescript
// lib/analytics.ts
import posthog from 'posthog-js'

export const track = (event: string, properties?: Record<string, unknown>) => {
  // Nur tracken wenn Consent gegeben
  if (typeof window === 'undefined' || !hasAnalyticsConsent()) return
  
  posthog.capture(event, {
    ...properties,
    // Niemals PII mitsenden
    $ip: false,  // IP-Anonymisierung
  })
}

// Verwendung:
track('aquarium_created', {
  tank_size: 200,
  is_first: true,
  // KEIN: email, name, etc.
})
```
