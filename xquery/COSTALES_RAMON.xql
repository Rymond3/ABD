for $b in doc("CUSTOMERS_ON.xml")/SALES/CUSTOMERS
  let $address := $b/ADDRESS
  let $ord := $b/ORDERS/ORDER
  let $sum := sum($ord/PRICE)
  where some $x in $ord
  satisfies $ord/PRICE <= 10000
  and $sum >= 23000
  order by $b/CUSTOMERNUMBER/@id descending
  return <result nombre="{$b/CONTACTFIRSTNAME} {$b/CONTACTLASTNAME}">
            <ciudad>{data($address/CITY)}</ciudad>
            <códigoEstado>{data($address/POSTALCODE)}</códigoEstado>
            <país>{data($address/COUNTRY)}</país>
            {for $or in $b/ORDERS
                let $cnt := count($or/ORDER)
                where $cnt < 3
                return <orden num="{$or/ORDER/@number}" />
            }
         </result>