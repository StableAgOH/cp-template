rm -rf pdf
mkdir -p pdf
mdfiles="md/*.md"
for mdfile in $mdfiles; do
    base=$(basename $mdfile .md)
    echo "Converting $base..."
    pandoc -s $mdfile -o pdf/$base.pdf --pdf-engine=xelatex --include-in-header=pagenumber.tex \
        -V CJKmainfont="Noto Sans CJK SC" \
        -V geometry:margin=2cm \
        -V title=$base
done
sleep 1
echo "Merging PDFs..."
qpdf --empty --pages pdf/*.pdf -- output.pdf
