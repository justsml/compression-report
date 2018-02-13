#!/bin/bash

## REQUIREMENTS: node, brotli, gzip

input_file=${1:-dist/bundle.min.js}
output_mode=${2:-yaml}

if [ ! -f "$input_file" ]; then
  if [ -f "$output_mode" ]; then
    ## Found reversed args, switch them
    tfile=$output_mode
    output_mode=$input_file
    input_file=$tfile
  fi
fi

if [ "$output_mode" == "yml" ]; then
  output_mode=yaml
fi


function compress {
  gzip   --force --keep --best --suffix '.gz' $input_file
  brotli --best -kf $input_file
}

function printSizeDiff {
   node --eval "console.log(($1 / $2.0).toFixed(2))"
}

function getFileSizes {
  export original_size=$(stat --format %s $input_file)
  export brotli_size=$(stat --format %s $input_file.br)
  export gzip_size=$(stat --format %s $input_file.gz)
}

function printYaml {
  printf "file: $input_file\n"
  printf "ouput_bytes:\n"
  printf "    original: $original_size\n"
  printf "    gzip:     $gzip_size\n"
  printf "    brotli:   $brotli_size\n"
  printf "pretty_size:\n"
  printf "    original: $(numfmt --to=iec $original_size)\n"
  printf "    gzip:     $(numfmt --to=iec $gzip_size)\n"
  printf "    brotli:   $(numfmt --to=iec $brotli_size)\n"
  printf "size_reduction:\n"
  printf "    gzip:     $(printSizeDiff $original_size $gzip_size)x\n"
  printf "    brotli:   $(printSizeDiff $original_size $brotli_size)x\n"
}

function printMarkdown {
  printf "### \`$input_file\` Compression Results \n"
  printf "| Utility     | File Size   |\n"
  printf "|-------------|-------------|\n"
  printf "| _original_  | $(numfmt --to=iec $original_size)\n"
  printf "| gzip        | $(numfmt --to=iec $gzip_size)  ($(printSizeDiff $original_size $gzip_size) X smaller)\n"
  printf "| brotli      | $(numfmt --to=iec $brotli_size)  ($(printSizeDiff $original_size $brotli_size) X smaller)\n"
}


getFileSizes

compress

if [ "$output_mode" == "yaml" ]; then
  printYaml
fi

if [ "$output_mode" != "yaml" ]; then
  printMarkdown
fi

