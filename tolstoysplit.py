import sys
import collections
import re
import random
alphabets= "([A-Za-z])"
prefixes = "(Mr|St|Mrs|Ms|Dr)[.]"
suffixes = "(Inc|Ltd|Jr|Sr|Co)"
starters = "(Mr|Mrs|Ms|Dr|He\s|She\s|It\s|They\s|Their\s|Our\s|We\s|But\s|However\s|That\s|This\s|Wherever)"
acronyms = "([A-Z][.][A-Z][.](?:[A-Z][.])?)"
websites = "[.](com|net|org|io|gov)"

# adapted from https://stackoverflow.com/questions/4576077/how-can-i-split-a-text-into-sentences
def split_into_sentences(text):
    text = " " + text + "  "
    text = text.replace("\n"," ")
    text = re.sub(prefixes,"\\1<prd>",text)
    text = re.sub(websites,"<prd>\\1",text)
    if "Ph.D" in text: text = text.replace("Ph.D.","Ph<prd>D<prd>")
    text = re.sub("\s" + alphabets + "[.] "," \\1<prd> ",text)
    text = re.sub(acronyms+" "+starters,"\\1<stop> \\2",text)
    text = re.sub(alphabets + "[.]" + alphabets + "[.]" + alphabets + "[.]","\\1<prd>\\2<prd>\\3<prd>",text)
    text = re.sub(alphabets + "[.]" + alphabets + "[.]","\\1<prd>\\2<prd>",text)
    text = re.sub(" "+suffixes+"[.] "+starters," \\1<stop> \\2",text)
    text = re.sub(" "+suffixes+"[.]"," \\1<prd>",text)
    text = re.sub(" " + alphabets + "[.]"," \\1<prd>",text)
    text = re.sub("\d+", "N", text)
    if "”" in text: text = text.replace(".”","”.")
    if "\"" in text: text = text.replace(".\"","\".")
    if "!" in text: text = text.replace("!\"","\"!")
    if "?" in text: text = text.replace("?\"","\"?")
    text = text.replace("."," .<stop>")
    text = text.replace("?"," ?<stop>")
    text = text.replace("!"," !<stop>")
    text = text.replace('"', " ")
    text = text.replace('-', " ")
    text = text.replace('“', " ")
    text = text.replace('”', " ")
    text = text.replace(",", "")
    text = text.replace("<prd>"," .")
    _RE_COMBINE_WHITESPACE = re.compile(r"\s+")
    text = _RE_COMBINE_WHITESPACE.sub(" ", text).strip()
    sentences = text.split("<stop>")
    sentences = sentences[:-1]
    sentences = [s.strip() for s in sentences]
    sentences = [s.lower() for s in sentences]
    return sentences


def replace_rare_words(sents, n=10000):
    wordcounts = collections.Counter()
    for s in sents:
        for w in s.split(" "):
            wordcounts[w] += 1
    wc = wordcounts.most_common(n)
    common = {k for k, v in wc} 
    newsents = []
    for s in sents:
        snew = []
        for w in s.split(" "):
            if w in common:
                snew.append(w)
            else:
                snew.append("<UNK>")
        newsents.append(" ".join(snew))
    return newsents





with open(sys.argv[1]) as f:
    random.seed(561)
    text = f.read() 
    text = text[7288:] # trim front matter
    text = text[:-18709] #trim back matter
    sents = split_into_sentences(text)
    sents = replace_rare_words(sents, 10000)
    sents = [s for s in sents if len(s) > 5]
    BLOCKLEN = 20
    nblocks = len(sents)//BLOCKLEN
    testvalind = random.sample(range(0,nblocks),
                               round(0.2 * nblocks))
    testind = set(testvalind[0:(len(testvalind)//2)])
    valind  = set(testvalind[(len(testvalind)//2):])
    trainsents = []
    testsents  = []
    valsents   = []
    for j, s in enumerate(sents):
        if (j // BLOCKLEN) in testind:
            testsents.append(s)
        elif (j // BLOCKLEN) in valind:
            valsents.append(s)
        else:
            trainsents.append(s)
    train = "\n".join(trainsents)
    val   = "\n".join(valsents)
    test  = "\n".join(testsents)
    with open("./warandpeace_train.txt", "w") as f:
        f.write(train)
    with open("./warandpeace_valid.txt", "w") as f:
        f.write(val)
    with open("./warandpeace_test.txt", "w") as f:
        f.write(test)

        
        

    






    
