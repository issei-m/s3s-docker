# s3s-docker 

The unofficial containerized version of [s3s](https://github.com/frozenpandaman/s3s), the tool that syncs your Splatoon 3's battle/Salmon Run results with [stat.ink](https://stat.ink/).
Before use it, you need to understand what s3s is and how it works at [the official repository](https://github.com/frozenpandaman/s3s).

**The official tool s3s is currently under development and rapidly updated without any specific stable version tag,
we catch up the main stream and reflect changes into `latest` tag, so frequent pull it is strongly recommended.**

Example usage:

```
docker run -t --rm -v $(pwd)/config.txt:/opt/s3s/config.txt isseim/s3s -M -r
```

You can specify s3s options after image name like above `-M -r`. 

## App Configuration

You already have a `config.txt` for s3s? That's cool. You can just mount it to the container's `/opt/s3s/config.txt` via volume-mounting so that s3s can load it as we showed you in the first example.
Or you can pass it via environment variables. See [Environments](#environments) section.

## Environments

### `S3S_CONFIG`

The whole content of the `config.txt` can directly be specified to s3s to load it via the `S3S_CONFIG` environment variable like:  

```
s3s_config=$(cat config.txt); docker run -t --rm -e S3S_CONFIG=$s3s_config isseim/s3s -M -r
```

It'd be a little bit useful if you've stored the content of `config.txt` to make sure the tokens are confidential using a secure storage such as AWS Parameter Store (SecureString).

## LICENCE

[GPLv3](https://choosealicense.com/licenses/gpl-3.0/) (complying with the official repository)
