rm -rf pdf
mkdir -p pdf
mdfiles="md/*.md"
for mdfile in $mdfiles; do
    base=$(basename $mdfile .md)
    echo "Converting $base..."
    pandoc -s $mdfile -o pdf/$base.pdf --pdf-engine=xelatex --include-in-header=pagenumber.tex \
        -V CJKmainfont="Noto Sans CJK SC" \
        -V fontsize=10pt \
        -V geometry:top=1cm \
        -V geometry:bottom=1cm \
        -V geometry:left=1.5cm \
        -V geometry:right=1.5cm \
        -V title=$base
done
sleep 1
echo "Merging PDFs..."
qpdf --empty --pages pdf/*.pdf -- output.pdf
