# dreamseige-wp
DreamHost Siege WordPress Testing Samples

## What Is This?

This repo includes basic WordPress templates with which to build basic WordPress sites to test for whatever you plan on blowing up.

## Prerequisites

* A location to run WordPress
* The ability to install a WordPress Site
* WP-CLI

## What's Included

* An index.php file
* A shell script
* 3 SQL files complete with content and theme and plugin configs
* Folders for each test type (basic, inter, and advan)
* A wp-content folder with media and plugins and themes
			
Post Content: [WordPress Theme Unit Test Data](https://wpcom-themes.svn.automattic.com/demo/theme-unit-test-data.xml)

### Basic

Theme: [Colorway](https://wordpress.org/themes/colorway/)

Plugins: Jetpack (dev mode), Contact Form 7, WP-Optimize, Google XML Sitemaps, WordPress SEO

### Intermediate

Theme: [Customizr](https://wordpress.org/themes/customizr/)

Plugins: Jetpack (dev mode), Contact Form 7, WP-Optimize, Google XML Sitemaps, WordPress SEO, iTheme Security

## Advanced

Theme: [Avada](http://theme-fusion.com/avada/)

Plugins: Jetpack (dev mode), Contact Form 7, WP-Optimize, Google XML Sitemaps, WordPress SEO, WordFence

wp plugin install jetpack --activate ; wp plugin install contact-form-7 --activate; wp plugin install wp-optimize --activate ; wp plugin install wordpress-seo --activate ; wp plugin install wordfence --activate

wp plugin install wordpress-importer --activate; wp import ../theme-unit-test-data.xml --authors=create --quiet

## Usage

1. Clone this Repo
3. Run ./setup.sh (you may need to adjust permissions)

Everything's installed relative to where you are.

The default user for all sites is admin with a password of password. You'll want to change that.

## To Do

Make a default config file you can make to pull your defaults from there.

* db host
* db user
* db user password
* base domain name
* default admin info for WP