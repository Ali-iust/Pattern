
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.StringTokenizer;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ALI
 */
public class FileReader {
    public void createDictionary() throws FileNotFoundException, IOException{
        entery[] dic = new entery[200000];
        int counter = 0;
        BufferedReader reader = new BufferedReader(new java.io.FileReader(new File("FinalOut.txt")));
        String line = reader.readLine();
        while(line != null){
            set_all(dic, counter);
            StringTokenizer token = new StringTokenizer(line);
            while(token.hasMoreTokens()){
                String word = token.nextToken();
                if(search(dic,word,counter)){
                    dic[counter] = new entery(word);
                    counter++;
                }
            } 
            line = reader.readLine();
        }
        entery[] new_dic = dic_post(dic, counter);
        int size = 0;
        for(int i=0;i<counter;i++){
            if(new_dic[i] != null){
                size++;
            }else{
                break;
            }
        }
        write(new_dic,size);
        System.out.println(size);
        double[][] feature = build_tf_idf(new_dic, "FinalOut.txt", size, 12000);
        write(feature, "final_features.txt");
    }
    
    private boolean search(entery[] dictionary,String word,int size){
        for(int i=0;i<size;i++){
            if(dictionary[i].getWord().equalsIgnoreCase(word)){
                dictionary[i].add();
                if(dictionary[i].isFlag()){
                    dictionary[i].add_doc();
                    dictionary[i].setFlag(false);
                }
                return false;
            }
        }
        return true;
    }
    
    public void write(entery[] dic,int len) throws FileNotFoundException, IOException{
        File output = new File("temp_threshold.txt");
        if(!output.exists()){
            output.createNewFile();
        }
        int counter = 0;
        PrintWriter writer = new PrintWriter(output);
        for(int i=0;i<len;i++){
            if(dic[i].getNum() > 9){
            String temp = dic[i].getWord() + " " + dic[i].getNum() + " " + dic[i].getDocument();
            writer.println(temp);
            counter++;            
            }
        }
        System.out.println(counter);
        
    }
    private void set_all(entery[] dic,int len){
        for(int i=0;i<len;i++){
            dic[i].setFlag(true);
        }
    }
    public double[][] build_tf_idf(entery[] dic,String input,int dic_size,int input_size) throws FileNotFoundException, IOException{
        double[][] tf_idf = new double[input_size][dic_size];
        BufferedReader reader = new BufferedReader(new java.io.FileReader(new File(input)));
        String line = reader.readLine();
        int counter = 0;
        while(line != null){
            tf[] new_tf = compute_freq(line);
            double[] idf = idf(new_tf, dic, input_size);
            int max = max(new_tf);
            for(int i=0;i<dic_size;i++){
                int index = search_tf(new_tf,dic[i].getWord());
                if(index == -1){
                    tf_idf[counter][i] = 0.5 * Math.log10(input_size / dic[i].getDocument());
                }else{
                    tf_idf[counter][i] = (0.5 + ((0.5 * new_tf[index].getFreq()) / max)) * idf[index];
                }
            }
            line = reader.readLine();
            counter++;
        }
        return tf_idf;
    }
    private double[] idf(tf[] input,entery[] dic,int doc_num){
        double[] ret = new double[input.length];
        for(int i=0;i<input.length;i++){
            if(input[i] != null){
                int t = 1;
                String word = input[i].getWord();
                for(entery e:dic){
                    if(e != null && e.getWord().equalsIgnoreCase(word)){
                        t = e.getDocument();
                        break;
                    }
                }
                ret[i] = Math.log10(doc_num / t);
            }
        }
        return ret;
    }
    private tf[] compute_freq(String line){
        StringTokenizer token = new StringTokenizer(line);
        tf[] ret = new tf[token.countTokens()];
        int counter = 0;
        while(token.hasMoreTokens()){
            boolean flag = true;
            String temp = token.nextToken();
            for(int i=0;i<counter;i++){
                if(ret[i].getWord().equalsIgnoreCase(temp)){
                    ret[i].add();
                    flag = false;
                    break;
                }
            }
            if(flag){
                ret[counter] = new tf(temp);
                counter++;
            }
            
        }
        return ret;
    }
    
    private int max(tf[] temp){
        int max = -1;
        for (tf temp1 : temp) {
            if (temp1 != null) {
                if (temp1.getFreq() > max) {
                    max = temp1.getFreq();
                }
            }
        }
        return max;
    }
    private int search_tf(tf[] temp,String word){
        for(int i=0;i<temp.length;i++){
            if(temp[i] != null && temp[i].getWord().equalsIgnoreCase(word)){
                return i;
            }
        }
        return -1;
    }
    public void write(double[][] tf_idf,String name) throws IOException{
        File output = new File(name);
        if(!output.exists()){
            output.createNewFile();
        }
        PrintWriter writer = new PrintWriter(output);
        for(int i=0;i<tf_idf.length;i++){
            for(int j=0;j<tf_idf[0].length;j++){
                writer.print(tf_idf[i][j]);
                writer.print(" ");
            }
        writer.println(); 
        }
    }
    
    private entery[] dic_post(entery[] dic,int size){
        entery[] new_dic = new entery[size];
        int counter = 1;
        new_dic[0] = new entery("#number#");
        for(int i=0;i<size;i++){
            boolean flag = false;
            try{
                float temp = Float.valueOf(dic[i].getWord());
            }catch(NumberFormatException e){
                flag = true;
            }
            if(!flag){
                new_dic[0].document = new_dic[0].document + dic[i].getDocument();
                new_dic[0].num = new_dic[0].num + dic[i].getNum();
            }else{
                String temp = dic[i].getWord();
                if(!temp.equalsIgnoreCase("the") && !temp.equalsIgnoreCase("am") && !temp.equalsIgnoreCase("is") && !temp.equalsIgnoreCase("are") && !temp.equalsIgnoreCase("'d")
                        && !temp.equalsIgnoreCase("so") && !temp.equalsIgnoreCase("in") && !temp.equalsIgnoreCase("by") && !temp.equalsIgnoreCase("it") && !temp.equalsIgnoreCase("or")
                        && !temp.equalsIgnoreCase("and") && !temp.equalsIgnoreCase("to") && !temp.equalsIgnoreCase("was") && !temp.equalsIgnoreCase("were") && !temp.equalsIgnoreCase("not")
                        && !temp.equalsIgnoreCase("'s") && !temp.equalsIgnoreCase("i") && !temp.equalsIgnoreCase("you") && !temp.equalsIgnoreCase("we") && !temp.equalsIgnoreCase("that") && !temp.equalsIgnoreCase("be")
                        && !temp.equalsIgnoreCase("our") && !temp.equalsIgnoreCase("him") && !temp.equalsIgnoreCase("his") && !temp.equalsIgnoreCase("as") && !temp.equalsIgnoreCase("does")
                        && !temp.equalsIgnoreCase("a") && !temp.equalsIgnoreCase("but") && !temp.equalsIgnoreCase("on") && !temp.equalsIgnoreCase("for") && !temp.equalsIgnoreCase("with")
                        && !temp.equalsIgnoreCase("they") && !temp.equalsIgnoreCase("their") && !temp.equalsIgnoreCase("'re") && !temp.equalsIgnoreCase("us") && !temp.equalsIgnoreCase("10th")
                        && !temp.equalsIgnoreCase("12th") && !temp.equalsIgnoreCase("s") && !temp.equalsIgnoreCase(",") && !temp.equalsIgnoreCase("pa") && !temp.equalsIgnoreCase("f") && !temp.equalsIgnoreCase("h") && !temp.equalsIgnoreCase("e")
                        && !temp.equalsIgnoreCase("me") && !temp.equalsIgnoreCase("sr")){
                    new_dic[counter] = dic[i];
                    counter ++;
                }
            }
        }
        return new_dic;
    }
            
}
