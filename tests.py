
def memorysize():
    x = 10**6
    n = 0
    print(x)
    while True:
        x //= 8
        if x < 8:
           break
        n += 1
    print(n,x)

    print((2**20)-1>(10**6))


def find_combinations(lst, current_combination=[], start_index=0):
    # Base case: Print the current combination
    print(current_combination)

    # Recursive case
    for i in range(start_index, len(lst)):
        current_combination.append(lst[i])
        find_combinations(lst, current_combination, i + 1)
        current_combination.pop()


l = []
with open("Combinations.txt", "r") as f:
    while True:
        l.append(f.readline())
        if l[-1] == "":
            break

with open("Combinations.txt", "w") as f:
    for i in range(len(l)-1):
        string = str(format(i,'b').zfill(5)+' '+l[i])
        f.write(string)

