%dw 2.0
output application/json

---

(payload.attributes filter $.directory == false).fileName