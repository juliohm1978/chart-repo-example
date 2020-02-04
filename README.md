# Helm Chart Repo Example

You can use Github User Content to host basically any static content you commit to your git repository.

This project shows an example of how you can host your own Helm Chart repo. Checkout the included `Makefile` for examples of how to package and index Helm charts.

## Create an empty Github repository

Official docs: <https://help.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-new-repository>

Remember to make your repository Public.

## Clone it and create your own chart

You can develop and test new charts locally.

```shell
git clone {MY_REPO}
mkdir index src
```

* `src` Directory for your charts source code.
* `index` Directory for your packaged and published charts.

Create a new chart using `helm create`.

```shell
helm create ./src/mychart
```

Once you are done editing your chart, you can package and index it.

```shell
helm package src/mychart -d index/
cd index
helm repo index .
```

To publish the new index and chart, simply commit and push.

```shell
git add .
git commit -m 'my awesome chart'
git push
```

## This is just an example

The included `Makefile` is a farily simple example. It will package `./src/mychart` into the `./index/` directory and update the `./index/index.yaml` file. Feel free to adapt it or replace it with your favorite building tool. The `helm package` and `helm repo index` commands inside are what really matters.

## Using your Helm Repo

Github User Content for your repo is accessible at:

<https://raw.githubusercontent.com/{USERNAME}/{REPO_NAME}/master/index/index.yaml>

> `{USERNAME}` is your Github username or group name for your project.
>
> `{REPO_NAME}` is the name of your Github repository.

For example, to add this particular repo to your local Helm installation:

```shell
helm repo add juliohm1978 https://raw.githubusercontent.com/juliohm1978/chart-repo-example/master/index
helm repo up

## check it out
helm search repo mychart
```

## Considerations

### Charts may not be published immediately

We can safely assume that Github runs a quite large operation. That means, your repository content is replicated among several instances in their infrastructure. Once you commit and push, the effects might not show immediately. It may take up to a couple of minutes for your new chart to appear under `raw.githubusercontent.com`. It's not very common, so keep an eye out. You might think that your local `helm repo up` is not working, but you can just wait a bit longer for their servers to replicate all user content.

### Your repo needs to be public

It may sound obvious, but yes. This example assumes your Github repo is public and freely accessible to everyone.
