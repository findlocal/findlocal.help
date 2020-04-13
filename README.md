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

### Lint

One default task has been defined in the `Rakefile`, executing `rubocop` and `eslint`. Launch it with just `rake`.
