# Projektin README: Shell Data Pipeline

## Yleiskuvaus
Tämä projekti on shell-skripteillä toteutettu data-analyysiputki, joka sisältää JSON-datan käsittelyn, analysoinnin ja enkoodausongelmien korjaamisen. Projekti on suunniteltu tehokkaaksi ja yksinkertaiseksi, ilman ulkoisia ohjelmointikieliä tai kirjastoja, kuten Pythonia.

**Huomio**: Tämä ei ole täysin automatisoitu pipeline, koska datan puhdistukseen käytettiin manuaalisesti suoritettua sed-komentoa enkoodausongelmien korjaamiseksi.

## Käytetyt työkalut
- **Shell-skriptit** (bash) datan prosessointiin ja analysointiin.
- **GNU-työkalut**:
  - `sed` enkoodausongelmien korjaamiseen.
  - `grep`, `awk` ja `sort` datan analysointiin.
- **ChatGPT**: Suunnittelun ja toteutuksen tueksi.

## Skriptit

### 1. `fetch_data.sh`
**Kuvaus**: Noutaa datan avoimuusrekisterin API:sta ja tallentaa sen raakadatana tiedostoon `2_data/open_registry_data.json`. Tallentaa lokit tiedostoon `5_logs/fetch_data.log`.

**Toiminnot**:
- Hakee JSON-muotoisen datan API-osoitteesta `https://public.api.avoimuusrekisteri.fi/open-data-register-notification`.
- Tallentaa noudetun datan `2_data`-kansioon.
- Kirjaa onnistumiset ja virheet lokitiedostoon.

**Käyttö**:
```bash
chmod +x 1_scripts/fetch_data.sh
./1_scripts/fetch_data.sh
```

### 2. `format_data.sh`
**Kuvaus**: Muokkaa raakadatana tallennetun JSON-tiedoston (2_data/open_registry_data.json) siistimpään muotoon ja tallentaa tuloksen tiedostoon `3_results/formatted_data.json`. Tallentaa lokit tiedostoon `5_logs/format_data.log`.

**Toiminnot**:
- Tarkistaa, onko raakadata olemassa.
- Muotoilee JSON-datan luettavampaan muotoon.
- Kirjaa onnistumiset ja virheet lokitiedostoon.

**Käyttö**:
```bash
chmod +x 1_scripts/format_data.sh
./1_scripts/format_data.sh
```

### 3. `analyze_data.sh`
**Kuvaus**: Suorittaa data-analyysin `3_results/formatted_data.json`-tiedostolle ja tuottaa tulokset lokitiedostoon `5_logs/analyze_data.log`.

**Toiminnot**:
- Laskee yritysten kokonaismäärän.
- Listaa kaikki uniikit toimialat (main industries).
- Laskee vuoden 2025 aikana rekisteröityjen yritysten määrän.
- Tulostaa kolme yleisintä toimialaa esiintymiskertojen mukaan.

**Käyttö**:
```bash
chmod +x 1_scripts/analyze_data.sh
./1_scripts/analyze_data.sh
```

Tulokset tallennetaan lokitiedostoon `5_logs/analyze_data.log`.

### 4. Enkoodausongelman korjaus
**Kuvaus**: Korjaa JSON-tiedoston enkoodausongelmat, joissa erikoismerkit ä, ö ja å näkyvät virheellisesti Unicode-muodossa.

**Käytetty komento**:
```bash
sed -i 's/\u00c3\u00a4/ä/g; s/\u00c3\u00b6/ö/g; s/\u00c3\u00a5/å/g' 3_results/formatted_data.json
```
**Tulos**: Kaikki virheelliset Unicode-merkit muunnettiin vastaaviksi erikoismerkeiksi (ä, ö, å).

## Lokit
Kaikki skriptien tuottamat lokitiedostot tallennetaan `5_logs`-kansioon. Lokitiedostot ovat selkeästi jäsenneltyjä ja helposti luettavia.

## Datalähde
Tämä projekti käyttää avoimuusrekisterin tietoaineistoa, jonka on julkaissut Valtiontalouden tarkastusvirasto lisenssillä **Creative Commons Attribution 4.0 International License**.

Lisätietoa aineistosta: [https://www.avoindata.fi/data/fi/apiset/avoimuusrekisterin-tietoaineisto](https://www.avoindata.fi/data/fi/apiset/avoimuusrekisterin-tietoaineisto).
## MIT-lisenssi

Tämä projekti on lisensoitu MIT-lisenssillä. Voit vapaasti käyttää, muokata ja jakaa projektia, kunhan mainitset alkuperäisen tekijän.
