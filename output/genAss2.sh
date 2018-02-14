#!/bin/bash
for rollno in $(tail -n +2 "../students.csv" | cut -d, -f2); do
  stack exec assigner ../assignment2.tex 2 "$rollno" > "$rollno.tex"
  pdflatex "$rollno.tex"
  pdflatex "$rollno.tex"
done
