from collections import deque

graph = {}
graph['me'] = ['Pavel', 'Anastasia', 'Dima']

graph['Pavel'] = ['Yaroslav', 'Lada']
graph['Anastasia'] = ['Yaroslav']
graph['Dima'] = ['Alexander', 'Vadiks']
graph['Yaroslav'] = []
graph['Lada'] = []
graph['Alexander'] = []
graph['Vadiks'] = []


def search_person(graph):
    search_queue = deque()
    search_queue += graph['me']
    checked = []
    while search_queue:
        person = search_queue.popleft()
        if person not in checked:
            if len(person) == 6:
                print(f'{person} have 6 letters in name')
                return True
            else:
                search_queue += graph[person]
                checked.append(person)
    return False

#   

def dfs(graph, node, visited):
    if node not in visited:
        visited.append(node)
        for k in graph[node]:
            dfs(graph,k, visited)
    return visited

visited = dfs(graph,'me', [])
# print(visited)

def dfs (graph,  node, visited, parent):
    if not node in visited:
        if node == 'Lada':
            print(f'Ура вы нашли Ладу, она находится в списке друзей {parent}')
            return True
        else:
            visited.append(node)
    for neibour in graph[node]:
        parent = node
        dfs(graph, neibour, visited, parent)
    return visited


visited = dfs(graph,'me', [], 'me')
# print(visited)