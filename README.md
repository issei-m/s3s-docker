# s3s-docker 

The unofficial containerized version of [s3s](https://github.com/frozenpandaman/s3s), the tool that syncs your Splatoon 3's battle/Salmon Run results with [stat.ink](https://stat.ink/).
Before use it, you need to understand what s3s is and how it works at [the official repository](https://github.com/frozenpandaman/s3s).

**The official tool s3s is currently under development and rapidly updated without any specific stable version tag,
we catch up the main stream and reflect changes into `latest` tag, so frequent pull it (or use `--pull always` of `docker run`) is strongly recommended.**

Example usage:

```
docker run -t --rm -v $(pwd)/config.txt:/opt/s3s/config.txt isseim/s3s -M -r
```

You can specify s3s options after image name like above `-M -r`. 

## App Configuration

You already have the `config.txt` for s3s? That's cool. You can just mount it to the container's `/opt/s3s/config.txt` via volume-mounting so that s3s can load it as we showed you in the first example.
Or you can pass it via environment variables. See [Environments](#environments) section.

**If you don't have it yet, you can get one by following steps:**

1. Hit the following command, it will start interacting you to create a new config file

```
docker run -it --rm --name s3s-for-config isseim/s3s -M
```

2. Fill the mandatory parameters that s3s asks you
3. Once configuration finished, s3s will start with monitoring mode like:

```
Waiting for new battles/jobs... (checking every 5 minutes)
Press Ctrl+C to exit. 300
```

4. Meanwhile, open a new terminal and retrieve the config file you created from the container:

```
docker cp s3s-for-config:/opt/s3s/config.txt .
```

5. Back to the first terminal, hit Ctrl-C to kill and remove the container 

## Environments

### `S3S_CONFIG`

The whole content of the `config.txt` can directly be specified to s3s to load it via the `S3S_CONFIG` environment variable like:  

```
s3s_config=$(cat config.txt); docker run -t --rm -e S3S_CONFIG="$s3s_config" isseim/s3s -M -r
```

It'd be a little useful if you've stored the content of `config.txt` to make sure the tokens are confidential using a secure storage such as AWS Parameter Store (SecureString).

## LICENCE

[GPLv3](https://choosealicense.com/licenses/gpl-3.0/) (complying with the official repository)
