# Local Help

This is a web app where people can help each other complete tasks during the COVID-19 emergency.

## Usage

Clone the repository, install the gems and packages, and run the migrations and seeds:

```sh
git clone git@github.com:jones-sam/local-help
cd local-help
bundle
yarn
rails db:migrate db:seed
```

### Cloudinary

You need to connect a [Cloudinary](https://cloudinary.com/users/register/free) account in order to store and fetch images with Active Storage.

Create an `.env` file at the root of the repository, then copy and paste your `CLOUDINARY_URL` there.

### Stripe
You will  need a `STRIPE_PUBLISHABLE_KEY`, `STRIPE_SECRET_KEY`, and `STRIPE_WEBHOOK_SECRET_KEY` in the `.env` to process payments.
Use ngrok to host your localhost, this will allow webhooks to work. In `development.rb` set `config.hosts << "YOUR NGROK URL"`, and in the stripe dashboard set up webhooks pointing to that url.

### Lint

One default task has been defined in the `Rakefile`, executing `rubocop` and `eslint`. Launch it with `rake`.
