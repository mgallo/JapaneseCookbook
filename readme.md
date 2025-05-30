# Welcome to my Japanese cookbook

[![Netlify Status](https://api.netlify.com/api/v1/badges/80a3d727-7506-4555-8637-07fbe3145b1e/deploy-status)](https://app.netlify.com/sites/courageous-rabanadas-aca8ca/deploys)

The cookbook is available at http://ricettegiapponesi.jeko.net/

To run locally

insall Retype

```bash
npm install retypeapp --global
```

Then run the following command in the root of the project

```bash
retype start
```

to update the `ricettario.json` file, run

```bash
ruby serialize_recipes.rb
```

to add an hook to the `serialize_recipes.rb` file,  install `husky`

```bash
npm install --save-dev husky
npx husky init
```
