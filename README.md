# AssemblyToyPrograms

Welcome to the AssemblyToyPrograms repository!

This repository is dedicated to experimenting with assembly language using NASM (Netwide Assembler) with Intel Syntax. Here you'll find various test programs written in assembly, each contained within its own folder.

There's also a tool provided called ```cmplasm``` (**C**o**MP**i**L**e **AS**se**M**bly) that compiles automatically the ```program.asm``` into an executable you can run.

## Getting Started

To compile and run the assembly programs, follow these steps:

1. Clone this repository to your local machine.

  ```bash
  git clone https://github.com/Rattle-Brain/AssemblyToyPrograms.git
  ```
3. Navigate to the directory of the program you want to run.
  ```bash
  cd AssemblyToyPrograms
  ```
3. Use the provided bash script `cmplasm` to compile the `.asm` program and link it using `ld`, creating an executable. For example:
  ```
  ./cmplasm ./path/to/your_program
  ```
4. Execute the generated executable to run the program.

### BEWARE

**CMPLASM is untested and not robust. Any misusage of the script may or may not result on deletion of the source code. For it to work properly DON'T write the extension. Just the name of the program.**

### Example DON'T

```bash
cmplasm readConsole/read.asm
```

This will delete anything that matches the ```read.* ```. Meaning your code is lost.

### Example DO

```bash
cmplasm readConsole/read
```

This will compile everything correctly to a i86 architecture, resulting in an executable called ```read```.

Feel free to tinker and modify the script to suit your needs.

**Backup of the code is advised before compiling**

## Contents

The repository is organized into folders, each containing a separate assembly program. Here's an overview of what you'll find:

- **helloWorld**: Prints "Hello World!" to the standard output
- **readConsole**: Reads an input and prints it to stdout.
- **loopAsm**: Loops 10 times printing ```Number: n```.
- **userInputLoop**: Loops the amount of times specified by the user. DOESN'T WORK

Feel free to explore the folders and delve into the individual programs to see how they work and experiment with assembly programming yourself.

## Contributing

Feel free to contribute on the improvement of the CMPLASM tool.

## License

This repository is licensed under the [Unlicense License](LICENSE). Feel free to use the code for educational or personal purposes.
