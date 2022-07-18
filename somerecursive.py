def numinstep(num, step):
    if step == 1:
        return num
    else:
        return num * numinstep(num, step-1)

result = numinstep(5, 3)
print(result)

# def countdown(num):
#     print(num)
#     return countdown(num-1)

# try:
#     # print(countdown(5))
# except RecursionError as err:
#     print('ok')


def count_elems(lst):
    if lst == []:
        return 0
    else: 
        lst.pop()
        return 1+count_elems(lst)

print(count_elems([1,2,3,4,5]))


def sum_elems_of_lst(lst):
    if lst == []:
        return 0
    else:
        return lst.pop()+sum_elems_of_lst(lst)

print(sum_elems_of_lst([1,2,3,4,5,6]))


def max_elem(lst):
    if len(lst) == 1:
        return lst[0]
    elif lst[0] <= lst[1]:
        lst.remove(lst[0])
        return max_elem(lst)
    elif lst[0] > lst[1]:
        lst.remove(lst[1])
        return max_elem(lst) 

print(max_elem([2,3,5,5,7,7,8,6,5,4,4,1,6]))




print([1,2,3,4,5][1:])