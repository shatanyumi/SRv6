import json


class Astar:
    speed = []
    rtt = []
    inf = float('inf')
    G = [[inf, inf, inf, inf, inf, inf, inf, inf, inf],
         [inf, inf, inf, inf, inf, inf, inf, inf, inf],
         [inf, inf, inf, inf, inf, inf, inf, inf, inf],
         [inf, inf, inf, inf, inf, inf, inf, inf, inf],
         [inf, inf, inf, inf, inf, inf, inf, inf, inf],
         [inf, inf, inf, inf, inf, inf, inf, inf, inf],
         [inf, inf, inf, inf, inf, inf, inf, inf, inf],
         [inf, inf, inf, inf, inf, inf, inf, inf, inf],
         [inf, inf, inf, inf, inf, inf, inf, inf, inf]
         ]
    data = {}

    def topo(self):
        with open('db.json', 'r') as f:
            self.data = json.load(f)
        self.speed = self.data['speed']
        self.rtt = self.data['rtt']
        print(self.speed)
        print(self.rtt)
        self.G[0][1] = self.speed[0] + self.rtt[0]
        self.G[1][2] = self.speed[1] + self.rtt[1]
        self.G[2][3] = self.speed[2] + self.rtt[2]
        self.G[3][4] = self.speed[3] + self.rtt[3]
        self.G[3][5] = self.speed[4] + self.rtt[4]
        self.G[5][4] = self.speed[5] + self.rtt[5]
        self.G[4][6] = self.speed[6] + self.rtt[6]
        self.G[6][7] = self.speed[7] + self.rtt[7]
        self.G[7][8] = self.speed[8] + self.rtt[8]
        print(self.G)

    def Dijkstra(self, G, start):
        # 输入是从 0 开始，所以起始点减 1
        start = start - 1
        inf = float('inf')
        node_num = len(G)
        # visited 代表哪些顶点加入过
        visited = [0] * node_num
        # 初始顶点到其余顶点的距离
        dis = {node: G[start][node] for node in range(node_num)}
        # parents 代表最终求出最短路径后，每个顶点的上一个顶点是谁，初始化为 -1，代表无上一个顶点
        parents = {node: -1 for node in range(node_num)}
        # 起始点加入进 visited 数组
        visited[start] = 1
        # 最开始的上一个顶点为初始顶点
        last_point = start

        for i in range(node_num - 1):
            # 求出 dis 中未加入 visited 数组的最短距离和顶点
            min_dis = inf
            for j in range(node_num):
                if visited[j] == 0 and dis[j] < min_dis:
                    min_dis = dis[j]
                    # 把该顶点做为下次遍历的上一个顶点
                    last_point = j
            # 最短顶点假加入 visited 数组
            visited[last_point] = 1
            # 对首次循环做特殊处理，不然在首次循环时会没法求出该点的上一个顶点
            if i == 0:
                parents[last_point] = start + 1
            for k in range(node_num):
                if G[last_point][k] < inf and dis[k] > dis[last_point] + G[last_point][k]:
                    # 如果有更短的路径，更新 dis 和 记录 parents
                    dis[k] = dis[last_point] + G[last_point][k]
                    parents[k] = last_point + 1

            # 因为从 0 开始，最后把顶点都加 1
        return {key + 1: values for key, values in dis.items()}, {key + 1: values for key, values in parents.items()}

    def process(self):
        self.topo()
        dis, parents = self.Dijkstra(self.G, 1)
        t = 8

        path = []
        while parents[t] != -1:
            path.append(t - 1)
            t = parents[t]
        path.reverse()

        sr_policy = ""
        sr_policy = sr_policy + "sr localsid fe01::10"

        sr_path = []
        for point in path:
            host = self.data['map']['num2host'][point]
            sr_path.append(host)
            sr_policy = sr_policy + " next " + self.data['equipment'][host]['localsid']

        return sr_path, sr_policy


if __name__ == '__main__':
    # Astar().topo()
    sr_path , sr_policy = Astar().process()
    print(sr_path)
    print(sr_policy)
