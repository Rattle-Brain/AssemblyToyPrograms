# AssemblyToyPrograms

Welcome to the AssemblyToyPrograms repository!

This repository is dedicated to experimenting with assembly language using NASM (Netwide Assembler) with Intel Syntax. Here you'll find various test programs written in assembly, each contained within its own folder.

There's also a tool provided called ```cmplasm``` (**C**o**MP**i**L**e **AS**se**M**bly) that compiles automatically the ```program.asm``` into an executable you can run.

## Getting Started

To compile and run the assembly programs, follow these steps:

### 1. Clone this repository to your local machine.

  ```bash
  git clone https://github.com/Rattle-Brain/AssemblyToyPrograms.git
  ```
### 2. Navigate to the directory of the program you want to run.

  ```bash
  cd AssemblyToyPrograms
  ```
### 3. Use the provided bash script `cmplasm` to compile the `.asm`

  ```bash
  ./cmplasm ./path/to/your_program -f <format> -o <./path/to/output_file> -g
  ```

  Alternatively, you can paste the cmplasm file into the `/usr/bin` directory to avoid having to write the `./`char sequence.

  Bear in mind that the flags are **optional** and if left unspecified cmplasm will compile to its default values:
  
  - No debug profiles

  - Output file with same name as input file, in the same directory

  - Using elf32 format
  
  For more information on the matter please run:

  ```bash
  ./cmplasm -h
  ```

### 4. Execute the generated executable to run the program.

## Contents

The repository is organized into folders, each containing a separate assembly program. Here's an overview of what you'll find:

- **helloWorld**: Prints "Hello World!" to the standard output
- **readConsole**: Reads an input and prints it to stdout.
- **loopAsm**: Loops 10 times printing ```Number: n```.
- **userInputLoop**: Loops the amount of times specified by the user.
- **itoa_asm_input**: Basically itoa() in *C*
Feel free to explore the folders and delve into the individual programs to see how they work and experiment with assembly programming yourself.

## License

This repository is licensed under the [Unlicense License](LICENSE). For more information, please view the [LICENSE](LICENSE).
