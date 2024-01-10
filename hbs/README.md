# Hugo Theme Bootstrap Skeleton

The starter template for [Hugo Bootstrap Theme][02] that install the theme as a Hugo module.

## Demo

|     Platform     |                              URL                              |
| ---------------- | ------------------------------------------------------------- |
| Netlify          | https://hbs-skeleton.netlify.app/                             |
| GitHub Pages     | https://projects.razonyang.com/hugo-theme-bootstrap-skeleton/ |
| Cloudflare Pages | https://hbs-skeleton.pages.dev/                               |
| Docker image     | See also [Dockerfile][01]                                     |

## Usage

Please make sure you have install the [build tools][08] prior to using this template.

1. Clone this repository**

   It's recommending cloning the repo by clicking the `Use this template` button, if you're hosting
   your code on GitHub.

   You can also clone it manually.

   ```shell
   git clone https://github.com/razonyang/hugo-theme-bootstrap-skeleton.git blog
   cd blog
   rm -rf .git
   git init -b main
   ```

   > [!WARNING]
   > The `rm -rf .git` is a dangerous action, please make sure that you enter the right folder.

2. Modify the `go.mod`**

   Replace the following line to yours, such as `module github.com/user/repo`.

   ```
   module github.com/razonyang/hugo-theme-bootstrap-skeleton
   ```

3. Commit and push changes to your repository**

   ```shell
   git add -A
   git commit -m 'First commit'
   git remote set-url origin github.com/user/repo
   git push origin main
   ```

## Server

1. Install dependencies**

   ```shell
   npm i
   ```

   Generally, this step only needs to be performed once for each local project.

2. Start server**

   ```shell
   hugo server
   ```

## Upgrade theme

```shell
hugo mod get github.com/razonyang/hugo-theme-bootstrap@master
hugo mod npm pack
npm update
git add go.mod go.sum package.json package-lock.json
git commit -m 'Update the theme'
```

You can also replace the `master` with stable [releases][03].

## Deployment

Make sure you've change the `baseURL` on `config/_default/config.yaml` before deploying your
site. Please also remove the `-b {url}` from the following files if you're using this template.

> [!NOTE]
> The `baseURL` is very important, the CSS, JS and Sitemap require it to be set.

This template supports GitHub Pages, Docker image, Netlify out-of-box. See also [Deployment][07] for
getting more detail.

- `.github/workflows/gh-pages.yml`

The following parameters also need to be tweaked.

- Replace the `utterances.*` or `giscus.*` with your own to get notified when someone comments.
- Modify the `repo` to your own, or delete it if it's unused.
- `contact.endpoint`.

There are some hooks under the `layouts/partials/hooks` folder for showing how to use them, please
feel free to delete them.

## Documentations

- [English][06]

<!-- link references -->
[01]: Dockerfile
[02]: https://github.com/razonyang/hugo-theme-bootstrap
[03]: https://github.com/razonyang/hugo-theme-bootstrap/releases
[04]: https://goproxy.cn
[05]: https://goproxy.io
[06]: https://hbs.razonyang.com/v1/en/
[07]: https://hbs.razonyang.com/v1/en/docs/deployment/
[08]: https://hbs.razonyang.com/v1/en/docs/getting-started/prerequisites/#build-tools
