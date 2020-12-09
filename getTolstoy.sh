echo "=== Acquiring datasets ==="
echo "---"
mkdir -p save

mkdir -p data
cd data
mkdir -p tolstoy
cd tolstoy

echo "- Downloading 'War and Peace'"

wget --continue https://www.gutenberg.org/files/2600/2600-0.txt
mv 2600-0.txt warandpeace_full.txt

python ../../tolstoysplit.py ./warandpeace_full.txt
mv warandpeace_train.txt train.txt
mv warandpeace_test.txt test.txt
mv warandpeace_valid.txt valid.txt

cd ..
cd ..

mkdir -p log

mkdir -p ./save/noreg/
mkdir -p ./save/dropout1/
mkdir -p ./save/dropout4/
mkdir -p ./save/dropout8
mkdir -p ./save/explicitonly
mkdir -p ./save/dropout8_implicit
mkdir -p ./save/explicit_implicit

echo "---"
echo "Hope I pass 740!"



