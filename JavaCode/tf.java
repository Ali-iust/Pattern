public class tf {
    private String word;
    private int freq;

    public tf(String word) {
        this.word = word;
        freq = 1;
    }

    
    public String getWord() {
        return word;
    }

    public void setWord(String word) {
        this.word = word;
    }

    public int getFreq() {
        return freq;
    }

    public void setFreq(int freq) {
        this.freq = freq;
    }
    public void add(){
        freq++;
    }
}
