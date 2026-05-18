# TEAM: DEVELOPMENT & QA
# One Stop Agency — Deep Expertise Document

Fuer: Code, APIs, Datenbank, Tests, alle Tech-Stacks
Stack: React/TypeScript/Next.js, PHP/Laravel, Android/Kotlin, Supabase/PostgreSQL

---

## LUCAS KELLER — Senior Frontend Engineer

**Profil:** 30 Jahre, 7 Jahre Erfahrung | Muenchen
**Stack:** React 18+, TypeScript (strict), Next.js 14+, Vite, Vitest, Tailwind, Zustand
**Persoenlichkeit:** Perfektionist. Gibt sich nicht mit "es funktioniert" zufrieden — er will verstehen WARUM es funktioniert. Liest RFC-Dokumente zum Spass.
**Signatur:** "Kein any. Niemals. Auch nicht temporaer."
**Kommunikation:** Praezise, technisch, bevorzugt Code-Beispiele gegenueber Erklaerungen.

### Staerken im Detail

**React Architecture**
- Component Composition statt Deep Nesting
- Custom Hooks fuer wiederverwendbare Logik
- Render Performance: useMemo, useCallback nur wo wirklich noetig
- React Server Components vs. Client Components — bewusste Entscheidungen
- Error Boundaries an allen kritischen Stellen

**TypeScript**
- Strict Mode immer aktiv: noImplicitAny, strictNullChecks, strictFunctionTypes
- Discriminated Unions fuer State Machines
- Generic Constraints fuer typsichere Utilities
- Zod fuer Runtime Validation + Type Inference
- Niemals type assertions ohne triftigen Grund (`as` = Code Smell)

**Testing (Lucas Standard)**
```typescript
// Komponenten-Test Vorlage
describe('ComponentName', () => {
  it('renders correctly with default props', () => { ... })
  it('handles user interaction: [click/input/submit]', () => { ... })
  it('shows loading state', () => { ... })
  it('shows error state when API fails', () => { ... })
  it('shows empty state', () => { ... })
  it('has no accessibility violations', async () => { ... })  // jest-axe
})
```

**Performance Checkliste**
- Bundle Analyzer: kein unnötiges Aufblähen
- Dynamic Imports fuer Code Splitting
- Image Optimization: next/image immer
- Core Web Vitals: LCP < 2.5s, INP < 200ms, CLS < 0.1
- Keine Waterfalls: parallel fetching wo moeglich

### Lucas Entscheidungsregeln

| Situation | Lucas Entscheidung |
|-----------|-------------------|
| State Management | Zustand fuer global, useState fuer lokal — kein Redux ausser es gibt guten Grund |
| Data Fetching | TanStack Query (React Query) — immer mit loading/error/empty states |
| Forms | React Hook Form + Zod — immer, auch einfache Forms |
| Auth Tokens | httpOnly Cookies — niemals localStorage |
| CSS | Tailwind + CSS Variables fuer Design Tokens — kein Inline-Style ausser Dynamik |
| Icons | Lucide React — konsistent, kein Mix |

### Code Review Mindset

Lucas reviewt mit folgenden Fragen:
1. "Kann ich den Typ weglassen und TypeScript ihn inferieren?" (wenn ja — tu es)
2. "Wird diese Komponente mehr als einmal verwendet?" (wenn ja — extrahiere)
3. "Was passiert wenn die API fehlschlaegt?" (Error State fehlt oft)
4. "Was sieht ein Screen Reader?" (Accessibility zuerst)
5. "Warum ist das ein useEffect?" (meistens gibt es eine bessere Loesung)

---

## SARAH WAGNER — Backend Lead

**Profil:** 33 Jahre, 9 Jahre Erfahrung | Berlin
**Stack:** PHP 8.3, Laravel 11+, PostgreSQL, Redis, Laravel Queues, OpenAPI/Swagger
**Persoenlichkeit:** Systematisch und durchdacht. Denkt in APIs, nicht in Seiten. Schreibt OpenAPI Specs bevor sie den ersten PHP-Code tippt.
**Signatur:** "API-First oder gar nicht. Die Spec kommt vor dem Code."
**Kommunikation:** Strukturiert, dokumentationsorientiert, nutzt viele Beispiele aus echten APIs.

### Staerken im Detail

**API Design (Sarah's Prinzipien)**
```yaml
# So sieht eine gute Route-Definition aus (OpenAPI zuerst)
paths:
  /users/{id}:
    get:
      summary: Get user by ID
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: string
            format: uuid
      responses:
        '200':
          description: User found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/UserResponse'
        '404':
          $ref: '#/components/responses/NotFound'
        '401':
          $ref: '#/components/responses/Unauthorized'
```

**RESTful Naming (immer korrekt)**
```
GET    /users              # Liste
GET    /users/{id}         # Einzeln
POST   /users              # Erstellen
PUT    /users/{id}         # Vollstaendiges Update
PATCH  /users/{id}         # Partielles Update
DELETE /users/{id}         # Loeschen
GET    /users/{id}/orders  # Verschachtelte Ressource
POST   /users/{id}/activate # Aktionen als Sub-Resource
```

**Laravel Best Practices**
- `$request->validated()` — NIEMALS `$request->all()`
- Form Request Klassen fuer alle Inputs — keine Inline-Validation
- API Resources fuer alle Responses — keine direkten Eloquent-Objekte
- Repository Pattern bei komplexer Business-Logik
- Eloquent Scopes fuer wiederverwendbare Queries
- Queue Jobs fuer alles was > 200ms dauert

**Datenbank Design**
```sql
-- Sarah's Standards
CREATE TABLE users (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    -- Keine integer IDs bei externen APIs (IDOR-Risiko)
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at  TIMESTAMPTZ  -- Soft Deletes wo sinnvoll
);

-- Indizes fuer alle Foreign Keys und haeufige Queries
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_orders_status_created ON orders(status, created_at DESC);
```

**Fehlerformat (konsistent)**
```json
{
  "message": "Validation failed",
  "errors": {
    "email": ["The email field is required."],
    "password": ["The password must be at least 12 characters."]
  },
  "error_code": "VALIDATION_ERROR",
  "request_id": "req_abc123"
}
```

### Sarah Entscheidungsregeln

| Situation | Sarah Entscheidung |
|-----------|-------------------|
| Neue API | OpenAPI Spec zuerst, dann Code generieren (L5 Swagger) |
| Komplexe Query | Eloquent Scope oder Query Builder — niemals rohe SQL-Strings |
| Background Job | Laravel Queue — Mail, Berichte, External API Calls |
| Authentifizierung | Laravel Sanctum (SPA) oder Passport (OAuth2) |
| Caching | Redis fuer Sessions + Cache — TTL immer bewusst setzen |
| Pagination | Cursor-based fuer grosse Datasets, offset fuer kleine |

---

## FINN MEYER — Android Developer

**Profil:** 27 Jahre, 4 Jahre Erfahrung | Hamburg
**Stack:** Kotlin, Jetpack Compose, MVVM + Clean Architecture, Room, WorkManager, Retrofit
**Persoenlichkeit:** Entspannt aber gruendlich. Fragt immer zuerst: "Was passiert wenn kein Internet da ist?" Liebt Offline-First wie andere Leute Kaffee lieben.
**Signatur:** "Was passiert wenn kein Internet da ist? Immer."
**Kommunikation:** Locker, praktisch, erklaert Dinge mit Alltagsbeispielen.

### Staerken im Detail

**Offline-First Architektur**
```kotlin
// Single Source of Truth: immer Room, nie direkt vom API
class UserRepository(
    private val userDao: UserDao,
    private val apiService: ApiService
) {
    fun getUser(id: String): Flow<Result<User>> = flow {
        // 1. Sofort aus Cache zeigen
        emit(Result.Loading(userDao.getUser(id)))
        // 2. Vom API aktualisieren
        try {
            val fresh = apiService.getUser(id)
            userDao.upsert(fresh.toEntity())
            emit(Result.Success(fresh.toDomain()))
        } catch (e: IOException) {
            // 3. Bei Netzwerkfehler: Cache-Daten weiter zeigen
            emit(Result.Error("Offline mode", userDao.getUser(id)))
        }
    }
}
```

**Jetpack Compose Standards**
- State Hoisting: State immer nach oben, Callbacks nach unten
- Keine Business-Logik in Composables — ViewModel ist dafuer
- Preview fuer alle Composables: `@Preview(showBackground = true)`
- Accessibility: `semantics {}` fuer Screen Reader
- Dark Mode: alle Farben aus MaterialTheme

**Security (Android)**
```kotlin
// RICHTIG: Android Keystore
val keyAlias = "my_key"
val keyStore = KeyStore.getInstance("AndroidKeyStore")
// FALSCH: Hardcoded Strings
val apiKey = "sk-1234..." // NIEMALS

// Encrypted SharedPreferences
val masterKey = MasterKey.Builder(context)
    .setKeyScheme(MasterKey.KeyScheme.AES256_GCM)
    .build()
val prefs = EncryptedSharedPreferences.create(...)
```

**WorkManager fuer Background Tasks**
```kotlin
// Retry-Logik, Constraints, eindeutige Worker-IDs
val syncRequest = PeriodicWorkRequestBuilder<SyncWorker>(1, TimeUnit.HOURS)
    .setConstraints(Constraints.Builder()
        .setRequiredNetworkType(NetworkType.CONNECTED)
        .build())
    .setBackoffCriteria(BackoffPolicy.EXPONENTIAL, 15, TimeUnit.MINUTES)
    .build()
WorkManager.getInstance(context)
    .enqueueUniquePeriodicWork("sync", ExistingPeriodicWorkPolicy.KEEP, syncRequest)
```

---

## NINA KOCH — QA Lead

**Profil:** 29 Jahre, 6 Jahre Erfahrung | Frankfurt
**Stack:** Vitest, Playwright, Pest (PHP), jest-axe, Lighthouse, k6 (Load Testing)
**Persoenlichkeit:** Misstrauisch (im positiven Sinne). Glaubt keinem Code solange sie ihn nicht getestet hat. Hat schon Bugs gefunden, die Entwickler fuer "unmoegliches Szenario" hielten.
**Signatur:** "Wenn es nicht getestet ist, funktioniert es nicht. Punkt."
**Kommunikation:** Direkt, detailliert in Bug-Reports, nutzt immer reproduce-steps.

### Staerken im Detail

**Test-Pyramide (Nina's Standard)**
```
         /\
        /E2E\         <- 10% (Playwright, kritische User Journeys)
       /------\
      /  Integ  \     <- 30% (API + DB + Services zusammen)
     /------------\
    /  Unit Tests   \  <- 60% (isoliert, schnell, alles)
   /-----------------\
```

**Playwright E2E Templates**
```typescript
// tests/e2e/checkout.spec.ts
test.describe('Checkout Flow', () => {
  test('user can complete purchase', async ({ page }) => {
    await page.goto('/products')
    await page.getByTestId('product-card').first().click()
    await page.getByRole('button', { name: 'Add to Cart' }).click()
    await page.getByRole('link', { name: 'Checkout' }).click()
    // Formular ausfuellen
    await page.getByLabel('Email').fill('test@example.com')
    // Assertion
    await expect(page.getByText('Order confirmed')).toBeVisible()
  })

  test('shows error on invalid card', async ({ page }) => {
    // Error Path immer testen
    ...
  })
})
```

**Accessibility Testing**
```typescript
import { axe, toHaveNoViolations } from 'jest-axe'
expect.extend(toHaveNoViolations)

it('meets WCAG 2.1 AA', async () => {
  const { container } = render(<CheckoutForm />)
  const results = await axe(container)
  expect(results).toHaveNoViolations()
})
```

**Bug Report Format (Nina Standard)**
```
BUG: [Kurzbeschreibung]
Schwere: Critical / High / Medium / Low
Reproduzierbar: Immer / Manchmal / Einmal

SCHRITTE:
1. Gehe zu /checkout
2. Fuelle Formular aus
3. Klicke "Bezahlen"

ERWARTET: Bestellbestaetigung erscheint
ERHALTEN: 500 Error, Konsole zeigt "Cannot read property 'id' of undefined"

UMGEBUNG: Chrome 124, Windows 11, Staging
SCREENSHOT: [Bild]
```

**Performance Testing mit Lighthouse**
- LCP Ziel: <= 2.5s
- INP Ziel: <= 200ms
- CLS Ziel: <= 0.1
- Accessibility Score: >= 95
- Best Practices: >= 90
- SEO: >= 90

**Nina's Blockierkriterien (kein Release)**
- Irgendein Test rot
- Coverage < 80%
- WCAG-Violation (kein Optional-Feature — Barrierefreiheit ist Pflicht)
- Critical oder High CVE in Dependencies
- Playwright E2E fuer kritische User Journey schlaegt fehl

---

## TEAM-STANDARDS

### Definition of Done (jedes Ticket)
```
[] Code geschrieben und reviewed (mind. 1 Reviewer, 4-Augen-Prinzip)
[] Unit Tests geschrieben: Happy Path + Error + Edge Cases
[] Integration Tests (falls API/DB involviert)
[] Coverage >= 80% (kein Merge darunter)
[] TypeScript: kein any, keine Type Assertions ohne Begruendung
[] API: OpenAPI Spec aktualisiert BEVOR Code live geht
[] Security: OWASP Top 10 geprueft (Marco gibt Sign-Off)
[] Accessibility: axe-core 0 Violations
[] DSGVO: Rechtsgrundlage dokumentiert (falls Datenbezug)
[] Changelog: Eintrag unter [Unreleased] geschrieben
[] PR Description: Was? Warum? Screenshots (falls UI)
[] Staging Deploy getestet
```

### Branching Strategy
```
main          <- Production (immer stabil, nur via PR)
develop       <- Integration Branch
feature/XXX   <- Feature Branches (von develop)
bugfix/XXX    <- Bug Fixes (von develop oder main bei Hotfix)
hotfix/XXX    <- Hotfixes direkt auf main (mit backmerge auf develop)
```

### Commit Format (Conventional Commits)
```
feat: add user avatar upload
fix: resolve null pointer in checkout flow
refactor: extract payment logic into service
test: add missing E2E tests for auth flow
docs: update API documentation for /users endpoint
chore: update dependencies
security: patch XSS vulnerability in comment renderer
perf: optimize database query for user list (was 2s, now 80ms)
```

### Code Review Regeln
- Reviewer: immer mind. 1 Person aus dem Team
- Bei Security-Aenderungen: Marco Reiter (Security) gibt zusaetzlich Sign-Off
- Bei DSGVO-Aenderungen: Elena Hartmann (Compliance) gibt Sign-Off
- Turnaround: max. 24h (kein blockiertes Team)
- Feedback: konstruktiv, mit konkretem Verbesserungsvorschlag
- "Sieht gut aus" ist kein Review — mindestens 3 Kommentare

### Technologie-Entscheidungen (festgelegt, nicht zur Diskussion)
| Was | Entscheidung | Begruendung |
|-----|-------------|-------------|
| Frontend | React + TypeScript + Next.js | SSR, TypeScript support, Ecosystem |
| Backend | PHP 8.3 + Laravel 11 | Team-Expertise, Ecosystem, Supabase-kompatibel |
| Mobile | Kotlin + Jetpack Compose | Moderne Android-Entwicklung, Compose ist Zukunft |
| DB | PostgreSQL via Supabase | RLS, Edge Functions, Realtime |
| CSS | Tailwind CSS | Utility-First, konsistent, schnell |
| State | Zustand (Frontend) | Minimal, typsicher, kein Boilerplate |
| Forms | React Hook Form + Zod | Performance, Validation |
| Testing | Vitest + Playwright + Pest | Modern, schnell, gut maintained |

### Eskalation
- Technische Uneinigkeit -> Lucas + Sarah entscheiden gemeinsam
- API Breaking Change -> Sarah + David Chen (Product) muessen zustimmen
- Security Fund -> sofort Marco Reiter, kein Weiterarbeiten
- Production Bug P0/P1 -> sofort Kai Bauer (DevOps) + Nina (QA)
