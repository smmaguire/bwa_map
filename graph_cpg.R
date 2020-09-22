library(tidyverse)
library(cowplot)

files<-list.files("~/Desktop/lab notebook - one note/Rloop/bismark_map/bam_files",pattern=".bed",
                  full.names = T)

file<-files[1]
path<-"/Users/smaguire/Desktop/lab notebook - one note/Rloop/bismark_map/bam_files/"
read_files<-function(file){
  file.name<-str_split(file,path,simplify=T)[2]
  read_delim(file,delim="\t",skip = 1,
             col_names = c("chr_name","start_pos",
                           "end_pos","meth_percent",
                           "meth_reads","unmeth_reads")) %>%
    mutate(coverage = meth_reads + unmeth_reads,
           DNA_type = ifelse(str_detect(file.name,"dsDNA"),"dsDNA","ssDNA"),
           APOBEC = case_when(str_detect(file.name,"-0x") ~ 0,
                              str_detect(file.name,"-10x") ~ 0.1,
                              str_detect(file.name,"-25") ~ 0.25,
                              str_detect(file.name,"-50") ~ 0.5,
                              str_detect(file.name,"-100") ~ 1,
                              str_detect(file.name,"-200") ~ 2
                              )
           )
}

data<-map(files,read_files) %>%
  bind_rows()


filter(data,coverage > 100) %>%
ggplot(aes(x=start_pos,y=100-meth_percent,col=DNA_type))+geom_line()+
  facet_wrap(~APOBEC) + ylab("Percentage of Converted Cytocines") +
  xlab("Cytosine position") + theme_cowplot()


filter(data,DNA_type=='ssDNA',APOBEC==2) %>%
  as.data.frame()


filter(data,coverage > 100) %>%
  ggplot(aes(x=start_pos,y=100-meth_percent,col=DNA_type))+geom_line()+
  facet_wrap(~APOBEC) + ylab("Percentage of Converted Cytocines") +
  xlab("Cytosine position") + theme_cowplot()


filter(data,coverage > 100) %>%
  ggplot(aes(x=factor(APOBEC),y=100-meth_percent,fill=DNA_type))+
  geom_boxplot() + ylab("Percentage of Converted Cytocines") +
  xlab("APOBEC Concentration") + theme_cowplot()
