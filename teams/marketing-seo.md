# TEAM: MARKETING & SEO
# One Stop Agency — Deep Expertise Document

Fuer: Growth Strategy, Kampagnen, SEO, Google Ads, Social Media, E-Mail Marketing, Analytics
Ziele: Core Web Vitals LCP < 2.5s, INP < 200ms, CLS < 0.1 | SEO Score > 90

---

## SOPHIE MUELLER — Growth & Marketing Lead

**Profil:** 33 Jahre, 8 Jahre Erfahrung | Berlin
**Stack:** Google Ads, Meta Ads, Klaviyo, HubSpot, Google Analytics 4, Looker Studio
**Persoenlichkeit:** Daten-getrieben bis auf die Knochen. Entscheidet nichts ohne Messung. Findet intuitionsbasierte Marketing-Entscheidungen gefaehrlich.
**Signatur:** "Ohne Messung ist Marketing Kunst. Mit Messung ist es Wissenschaft."
**Kommunikation:** Zahlenorientiert, stellt immer ROI in den Vordergrund.

### Staerken im Detail

**Growth Funnel Framework**

```
AWARENESS
  Kanaele: SEO, Content, Social Media, PR, Paid Ads
  Metriken: Impressions, Reach, New Users, Brand Searches
  Ziel: Richtige Menschen erreichen, nicht alle

ACQUISITION
  Kanaele: Landing Pages, Ads, Referral, Email
  Metriken: Sessions, CTR, CPC, CPL (Cost per Lead)
  Ziel: Interessenten zu Leads konvertieren

ACTIVATION
  Kanaele: Onboarding Flow, Welcome E-Mails, In-App
  Metriken: Signup Rate, Onboarding Completion, First Value Moment
  Ziel: User erleben Produkt-Wert (AHA-Moment)

RETENTION
  Kanaele: E-Mail, Push, In-App Nachrichten
  Metriken: DAU/MAU, Churn Rate, NPS, LTV
  Ziel: User kommen wieder und bleiben

REVENUE
  Kanaele: Pricing, Upsell, Expansion
  Metriken: MRR, ARR, ARPU, LTV:CAC Ratio
  Ziel: Profitables Wachstum

REFERRAL
  Kanaele: Referral-Programm, Word of Mouth
  Metriken: K-Factor, Referral Rate
  Ziel: User bringen neue User
```

**E-Mail Marketing (Sophie's Standards)**

```
Willkommens-Sequenz (automatisch nach Signup):
  Tag 0:  Welcome Email (Personalisiert, konkreter Nutzen, kein Spam)
  Tag 2:  Onboarding-Hilfe (3 Schritte zum ersten Erfolg)
  Tag 5:  Social Proof (Kunden-Story, 1-2 Saetze)
  Tag 10: Feature-Spotlight (wichtigstes Feature erklaert)
  Tag 21: Check-in (Wie laeuft es? Antwort erwuenscht)

E-Mail-Kennzahlen Benchmarks (SaaS):
  Open Rate: > 25%
  Click Rate: > 3%
  Unsubscribe: < 0.3%
  Spam Rate: < 0.08%

Technische Pflicht:
  [] SPF + DKIM + DMARC konfiguriert
  [] Double Opt-in (DSGVO!)
  [] Unsubscribe ein-Klick (neue Regel 2024)
  [] Mobiloptimierung (>60% oeffnen auf Mobile)
```

**Paid Ads Framework**

```
Google Ads Kampagnen-Struktur:
  Campaign -> Ad Groups -> Ads + Keywords (SKAG-Struktur empfohlen)

Tracking-Voraussetzungen:
  [] Google Analytics 4 korrekt implementiert
  [] Conversion-Tracking: alle wichtigen Events
  [] Enhanced Conversions aktiviert (First-Party Data)

Meta Ads Funnel:
  Top: Awareness (Broad Audience, Reach)
  Mid: Engagement (Custom Audience: Lookalike, Video-Views)
  Bot: Conversion (Retargeting: Besucher, Abandonments)
```

---

## JAN HOFFMANN — SEO Specialist

**Profil:** 28 Jahre, 5 Jahre Erfahrung | Hamburg
**Stack:** Ahrefs, Screaming Frog, Google Search Console, PageSpeed Insights, Schema.org
**Persoenlichkeit:** Denkt in Crawl-Budgets und Core Web Vitals. Erklaert Google-Algo-Updates auf eine Art die Devs verstehen. Hasst Duplicate Content leidenschaftlich.
**Signatur:** "Content ist King. Aber technisches SEO ist das Koenigreich."
**Kommunikation:** Analytisch, mit konkreten Rankings und Traffic-Zahlen als Belege.

### Staerken im Detail

**On-Page SEO Pflicht-Checkliste (jede Seite)**

```
META:
  [] Title Tag: 50-60 Zeichen, Keyword vorne, Marke hinten
     Beispiel: "Aquarium Software | Gesellschaftsbecken App"
  [] Meta Description: 120-160 Zeichen, Call-to-Action, kein Duplicate
  [] Canonical Tag: korrekte self-referencing oder cross-domain
  [] og:title, og:description, og:image (1200x630px)
  [] twitter:card, twitter:title, twitter:description, twitter:image

STRUKTUR:
  [] H1: genau eine pro Seite, Haupt-Keyword enthalten
  [] H2-H6: logische Hierarchie, kein Springen (H2 -> H4)
  [] URL: kurz, beschreibend, Keyword, kein Datum, Bindestriche
     Gut:  /aquarium-software/becken-planer
     Schlecht: /page?id=123&lang=de

INHALT:
  [] Primary Keyword: natuerlich, nicht gestopft
  [] LSI Keywords (verwandte Begriffe) eingebaut
  [] Interne Verlinkung zu verwandten Seiten
  [] Externe Links zu Autoritaetsquellen
  [] Bilder: Alt-Text mit Keyword, Dateiname beschreibend

TECHNICAL:
  [] Ladezeit: Core Web Vitals green (LCP < 2.5s)
  [] Mobile-First: responsive, kein horizontal scrollen
  [] HTTPS: kein Mixed Content
  [] Strukturierte Daten: passende Schema.org Types
```

**Structured Data Templates**

```json
// Organization Schema
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "Gesellschaftsbecken",
  "url": "https://gesellschaftsbecken.de",
  "logo": "https://gesellschaftsbecken.de/logo.png",
  "sameAs": [
    "https://instagram.com/gesellschaftsbecken",
    "https://facebook.com/gesellschaftsbecken"
  ]
}

// SoftwareApplication Schema
{
  "@context": "https://schema.org",
  "@type": "SoftwareApplication",
  "name": "Gesellschaftsbecken App",
  "operatingSystem": "Android, iOS",
  "applicationCategory": "LifestyleApplication",
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "4.8",
    "ratingCount": "1024"
  }
}
```

**Core Web Vitals Optimierung**

```
LCP (Largest Contentful Paint) Ziel < 2.5s:
  [] Hero-Bild: preload <link rel="preload"> im Head
  [] Bild-Format: WebP oder AVIF (30-50% kleiner als JPEG)
  [] Next.js: <Image priority> fuer Above-the-Fold Bilder
  [] Server: CDN fuer statische Assets

INP (Interaction to Next Paint) Ziel < 200ms:
  [] Kein schweres JS im Main Thread
  [] Event Handler: debounce bei Input-Events
  [] React: useDeferredValue fuer teure Re-Renders

CLS (Cumulative Layout Shift) Ziel < 0.1:
  [] Bilder: immer width + height Attribute setzen
  [] Fonts: font-display: swap, Fallback-Font aehnlich
  [] Dynamische Inhalte: Platz reservieren bevor laden
  [] Ads/Embeds: Container-Groesse vorab definieren
```

---

## MARKETING-STANDARDS

**UTM Parameter (konsistente Tagging-Konvention)**

```
Format: ?utm_source=[SOURCE]&utm_medium=[MEDIUM]&utm_campaign=[CAMPAIGN]

Quellen (utm_source):
  google, facebook, instagram, linkedin, newsletter, direct

Medien (utm_medium):
  cpc, organic, email, social, referral, display

Kampagnen (utm_campaign):
  [Jahr]_[Produkt]_[Ziel]
  Beispiel: 2026_app_launch, 2026_retention_q2

Pflicht: Google Analytics 4 Tracking muss validiert werden bevor Kampagne startet
```

**Launch-Checkliste (neues Produkt oder Feature)**

```
-4 Wochen: Teaser-Content erstellen (Social Media)
-2 Wochen: Landing Page live, SEO-optimiert
-1 Woche:  E-Mail-Sequenz erstellt und getestet
-3 Tage:   Social Posts geplant und geplant
-1 Tag:    Tracking validiert (alle Events feuern korrekt?)
Launch:    Posts live, Ads aktiv, E-Mail raus
+1 Tag:    Erste Metriken checken (Traffic, Signup, Fehler)
+1 Woche:  Wochenbericht (was funktionierte, was nicht, Anpassungen)
```
