# compression-report
Analyze size savings using GZip &amp; Brotli. Exports in YAML &amp; Markdown Tables

## Install

```sh
# Add script to home path - move if needed
curl -o ~/compression-report.sh https://raw.githubusercontent.com/justsml/compression-report/master/compression-report.sh
# Add execute permissions
chmod +x ~/compression-report.sh
```


## Command Usage

```sh
# for markdown
~/compression-report.sh md dist/bundle.min.js
```
[see preview](#preview-markdown)


```sh
# for yaml
~/compression-report.sh yaml dist/bundle.min.js
```
[see preview](#example-yaml)


### Preview Markdown

#### `dist/bundle.min.js` Compression Results
| Utility     | File Size   |
|-------------|-------------|
| _original_  | 17K
| gzip        | 4.3K  (3.74 X smaller)
| brotli      | 3.9K  (4.18 X smaller)


### Example YAML

```yaml
file: "dist/bundle.min.js"
ouput_bytes:
    original: 16391
    gzip:     4384
    brotli:   3918
pretty_size:
    original: 17K
    gzip:     4.3K
    brotli:   3.9K
size_reduction:
    gzip:     3.74x
    brotli:   4.18x
```


### Raw Markdown Preview

```md
### `dist/bundle.min.js` Compression Results
| Utility     | File Size   |
|-------------|-------------|
| _original_  | 17K
| gzip        | 4.3K  (3.74 X smaller)
| brotli      | 3.9K  (4.18 X smaller)
```

