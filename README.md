# s3s-docker 

The unofficial containerized version of [s3s](https://github.com/frozenpandaman/s3s), the tool that syncs your Splatoon 3's battle/Salmon Run results with [stat.ink](https://stat.ink/).
Before use it, you need to understand what s3s is and how it works at [the official repository](https://github.com/frozenpandaman/s3s).

Example usage:

```
docker run -t --rm -v $(pwd)/config.txt:/opt/s3s/config.txt isseim/s3s -M -r
```

You can specify s3s options after image name like above `-M -r`. 

## LICENCE

[GPLv3](https://choosealicense.com/licenses/gpl-3.0/) (complying with the official repository)
