# personal-warehouse-dashboard

Dashboard de ma médiathèque personnelle — livres, musique et films — construit avec **Evidence.dev** et déployé sur **Netlify**.

👉 **https://mediatheque.jeremymarchandeau.com**

> Partie visualisation du projet [personal-warehouse](https://github.com/jeremy6680/personal-warehouse) (dbt + BigQuery).

---

## Stack

| Concern | Outil |
|---|---|
| Framework dashboard | [Evidence.dev](https://evidence.dev) (SQL-in-Markdown → site statique) |
| Query engine (local) | DuckDB WASM (sur les fichiers Parquet mis en cache) |
| Source de données | BigQuery (`personal-warehouse-495013`) via connecteur Evidence |
| Déploiement | Netlify (build déclenché à chaque push sur `main`) |
| Domaine | `mediatheque.jeremymarchandeau.com` |

---

## Pages

| Page | URL | Source dbt |
|---|---|---|
| Accueil | `/` | `mrt_music__collection` |
| Résumé | `/summary` | `mrt_media__summary` |
| Carte du monde | `/map` | `mrt_media__country_index` |
| Musique — Collection | `/music/collection` | `mrt_music__collection` |
| Musique — Statistiques | `/music/stats` | `mrt_music__collection` |
| Livres — Collection | `/books/collection` | `mrt_books__collection` |
| Livres — Statistiques | `/books/stats` | `mrt_books__collection` |
| Films — Collection | `/movies/collection` | `mrt_movies__collection` |
| Films — Statistiques | `/movies/stats` | `mrt_movies__collection` |

---

## Lancer en local

```bash
# 1. Installer les dépendances
npm install

# 2. Tirer les données depuis BigQuery (génère les fichiers Parquet locaux)
npm run sources

# 3. Lancer le serveur de développement
npm run dev
```

Ouvre http://localhost:3000 dans ton navigateur.

> **Prérequis :** un fichier `sources/personal_warehouse/connection.options.yaml` avec les credentials BigQuery (voir ci-dessous). Ce fichier est git-ignoré.

---

## Configuration des credentials BigQuery

Crée le fichier `sources/personal_warehouse/connection.options.yaml` :

```yaml
client_email: <BASE64 de l'email du service account>
private_key: <BASE64 de la clé privée>
```

Les valeurs doivent être encodées en base64 — Evidence applique `decodeBase64Deep` sur ce fichier.

```bash
# Encoder une valeur
echo -n "ta-valeur" | base64
```

---

## Variables d'environnement (Netlify)

Pour le build en production, les credentials sont passés via des variables d'environnement Netlify.

> ⚠️ **Important :** la partie option du nom de variable doit être en **minuscules** — Evidence est case-sensitive sur les noms d'options.

| Variable | Valeur |
|---|---|
| `EVIDENCE_SOURCE__PERSONAL_WAREHOUSE__client_email` | email du service account (texte brut) |
| `EVIDENCE_SOURCE__PERSONAL_WAREHOUSE__private_key` | clé privée (texte brut, avec les `\n`) |

---

## Build de production

```bash
npm run build
# Le site statique est généré dans ./build
```

---

## Architecture

Ce repo est la couche visualisation d'un pipeline complet :

```
CSV exports + Spotify API
        ↓
    BigQuery (raw_personal)
        ↓
    dbt Core (staging → intermediate → mart)
        ↓
    Evidence.dev (ce repo)
        ↓
    Netlify → mediatheque.jeremymarchandeau.com
```

Voir le repo dbt : [jeremy6680/personal-warehouse](https://github.com/jeremy6680/personal-warehouse)
