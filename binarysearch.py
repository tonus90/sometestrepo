def binary_search(arr, number):
    high = len(arr)-1
    low = 0
    while low <= high:
        middle = (low+high)//2
        guess = arr[middle]
        if number == guess:
            return f'{middle} угадано'
        elif number > guess:
            low = middle + 1
        else:
            high = middle - 1
    return None


arr = [1, 2, 3, 4, 5, 6, 7, 8]

result = binary_search(arr, 5)

print(result)

def binary_search_recursive(arr, number):
    high = len(arr)-1
    low = 0
    middle = (high+low)//2
    if number == arr[middle]:
        return middle
    elif number > arr[middle]:
        return binary_search_recursive(arr[middle+1:], number)+(middle + 1)
    elif number < arr[middle]:
        return binary_search_recursive(arr[:middle], number)
    else:
        return None

arr = [1, 2, 3, 4, 5, 6, 7, 8]

result = binary_search_recursive(arr, 3)

print(result)


arr = [1, 2, 3, 4, 5, 6, 7, 8]

result = binary_search(arr, 5)

print(result)

arr = [1, 1, 2, 3, 4, 4, 5, 6, 7, 8]

def find_duplicate(arr):
    high = len(arr)-1
    low = 0
    duplicates = []
    middle = (high+low)//2
    if arr[high] == arr [low]:
        duplicates.arr[low]
    elif arr[high] > arr [low]:
        return find_duplicate(arr[middle:])
    else:
        pass

# def pairwise(iterable):
#     "s -> (s0, s1), (s2, s3), (s4, s5), ..."
#     a = iter(iterable)
#     return zip(a, a)

# for x, y in pairwise(arr):
#    if x == y:
#        print(x, end=' ')

duplicates = []
arr = [1, 1, 1, 2, 3, 4, 4, 5, 6, 7, 8]
# for i in range(len(arr)-1):
#     if arr[i] == arr[i+1]:
#         duplicates.append(arr[i])
last_duplicate = None
for i, v in enumerate(arr):
    if v == arr[i-1] and last_duplicate != v:
        duplicates.append(v)
        last_duplicate = v


print(*duplicates)