# assigner

Haskell program for generating unique (different for different students) assignments by choosing *M* questions randomly from an [exam class](https://ctan.org/pkg/exam) LaTeX file containing *N* questions. The output can be seen at [https://www.ee.iitb.ac.in/~sarva/courses/EE720/2018/assignments/assignment2/](https://www.ee.iitb.ac.in/~sarva/courses/EE720/2018/assignments/assignment2/)

## Generating the assignments
- Install [stack](https://docs.haskellstack.org/)
- Clone this repository
- Run `stack build` in the repository root (this will take some time to finish if you are using `stack` for the first time).
- Copy your exam class LaTeX file into the repository root (for example, see the `assignment2.tex` file in repository).
- Change to `output` directory by running `cd output`.
- Run `source genAss2.sh` to generate the assignments in the `output` directory (both `.tex` and `.pdf` files will be generated).  The names of the files are the roll numbers of the students in the `students.csv` file.

## Sources
- `src/Main.hs` has the program to generate the assignments. It is compiled into an executable `assigner` which can be executed using the command `stack exec assigner <LaTeXFileName> <M> <string>`. The argument `<string>` can be an arbitrary string which provides the randomness required to generate a unique assignment.


## License
MIT
    
