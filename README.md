# Node-Nav 导航站

- 用于node环境的玩具和容器，基于node三方ws库，vless+trojan双协议，集成哪吒探针服务。

---

### 📌 各变量说明

  | 变量名        | 是否必须 | 默认值 | 备注 |
  | ------------ | ------ | ------ | ------ |
  | UUID         | 否 |7da59679-2fb0-4179-a15d-37bb42f3aabb| 开启了哪吒v1,请修改UUID|
  | PORT         | 否 |  7860  |  监听端口                    |
  | NEZHA_SERVER | 否 |        |哪吒v1填写形式：nz.abc.com:8008   哪吒v0填写形式：nz.abc.com|
  | NEZHA_PORT   | 否 |        | 哪吒v1没有此变量，v0的agent端口| 
  | NEZHA_KEY    | 否 |        | 哪吒v1的NZ_CLIENT_SECRET或v0的agent端口 |
  | NAME         | 否 |        | 节点名称前缀，例如：Glitch |
  | DOMAIN       | 是 |        | 项目分配的域名或已反代的域名，不包括https://前缀  |
  | SUB_PATH     | 否 |  sub   | 订阅路径   |
  | AUTO_ACCESS  | 否 |  false | 是否开启自动访问保活,false为关闭,true为开启,需同时填写DOMAIN变量 |

---

### 使用cloudflare workers 或 snippets 反代域名给节点套cdn加速
```
export default {
    async fetch(request, env) {
        let url = new URL(request.url);
        if (url.pathname.startsWith('/')) {
            var arrStr = [
                'change.your.domain', // 此处单引号里填写你的节点伪装域名
            ];
            url.protocol = 'https:'
            url.hostname = getRandomArray(arrStr)
            let new_request = new Request(url, request);
            return fetch(new_request);
        }
        return env.ASSETS.fetch(request);
    },
};
function getRandomArray(array) {
  const randomIndex = Math.floor(Math.random() * array.length);
  return array[randomIndex];
}
```
