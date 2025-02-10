# Mirror Master aka Repo Syncer

## Introduction

Mirror Master is a lightweight docker image that uses [skopeo](https://github.com/containers/skopeo), to sync images between docker images registries, it supports all the registries supported by Skopeo such as _GCR_, _Docker Hub_, _ECR_ and _Quay_.

### If Skopeo does the job why I need this image?

That's a fair question! 

**_Answer:_** Skopeo is awesome to deal with the complexity of docker manifest and authentication between registries, but not with filtering which tags you wanna sync (as you can see [here](https://github.com/containers/skopeo/blob/master/docs/skopeo-sync.1.md) the _sync_ command does not have a `--filter` option), which leaves to you the burden/hassle/fun of list all tags and somehow decide what you want to ignore or not.

_Mirror Master_  is meant to be a simple wrapper around the awesome work of Skopeo, easy to customize and use.

## Default Variables

The default variables are environments variables that can be used to configure the container. 

| Name             | Description                                                                                                                                                          | Mandatory? |
| ---------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--------: |
| images-list.txt  | Text File with {projectName}/{repository}/{image:tag}                                                                                                                |    YES     |
| SOURCE_REGISTRY  | Source Registry from where the images will be copied.                                                                                                                |    YES     |
| DEST_REGISTRY    | Destination Registry where the images will be copied.                                                                                                                |    YES     |

## Authors
[Stephan Kristyn](https://github.com/wethinkagile) / [Phil Carvalho](https://github.com/philippescar)
