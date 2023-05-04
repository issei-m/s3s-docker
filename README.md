# s3s-docker 

The unofficial container image of [s3s](https://github.com/frozenpandaman/s3s), the tool that syncs your Splatoon 3's battle/Salmon Run results with [stat.ink](https://stat.ink/).
Before use it, you need to understand what s3s is and how it works at [the official repository](https://github.com/frozenpandaman/s3s).

**The official tool s3s is currently under development and rapidly updated without any specific stable version tag,
we catch up the main stream and reflect changes into `latest` tag, so frequent pull it (or use `--pull always` of `docker run`) is strongly recommended.**

## Usage example

If you already have your own `config.txt` for s3s, it can be passed via the environment variable `S3S_CONFIG` like this:

```
s3s_config=$(cat config.txt); docker run -it --rm -e S3S_CONFIG="$s3s_config" isseim/s3s -M -r
```

💡 You can specify s3s options after image name like above `-M -r`.

### If you don't have it yet, you can get one by following steps:

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

## LICENCE

[GPLv3](https://choosealicense.com/licenses/gpl-3.0/) (complying with the official repository)
