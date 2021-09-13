local key = KEYS[1]
local value = ARGV[1]
local expire = ARGV[2]

if redis.call("SET", key, value, "NX", "EX", expire) then
    return 1
    --ttl当 key 存在但没有设置剩余生存时间时，返回 -1
elseif redis.call("TTL", key) == -1 then
--设置成功返回 1 。 当 key 不存在或者不能为 key 设置过期时间时返回 0
    redis.call("EXPIRE", key, expire)
end
return 0


