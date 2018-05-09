
import sys
from random import randrange
from student import Student
from match import spectrum

def make_mock_responses(n, q, c):
    roster = []
    for i in range(n):
        responses = [randrange(0, c) for i in range(q)]
        roster.append(Student(i, responses))
    return roster

def print_students(students):
    for s in students:
        s.write_responses()

def main():
    if len(sys.argv) != 4:
        raise "Incorrect Number of Arguments"
    n = int(sys.argv[1]) # number of respondants
    q = int(sys.argv[2]) # number of questions
    c = int(sys.argv[3]) # number of responses

    students = make_mock_responses(n, q, c)
    print("mock responses")
    print_students(students)
    print()
    print("organized responses")
    organized_students = spectrum(students)
    print_students(organized_students)

    print("Done making test surveys")

if __name__ == "__main__":
    main()