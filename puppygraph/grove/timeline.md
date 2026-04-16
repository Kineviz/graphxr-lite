<!--{"pinCode":false,"dname":"6a6c7180-0165-4b0f-b1f8-508b11522f64","codeMode":"markdown"}-->
```md
### Timeline plot
Type the name of date field below and plot nodes in timeline. Date should be iso format
```

<!--{"pinCode":false,"dname":"84e40639-12f8-45d5-b2f8-e2489851f3ba","codeMode":"js"}-->
```js
viewof datefield=Inputs.text({label:'Date Field Name', value: 'access_time'})
```

<!--{"pinCode":false,"dname":"89751a8e-1cef-4b53-a616-bf8514110313","codeMode":"js"}-->
```js
viewof orientation = Inputs.radio(['up', 'down'], {value:'down', label:'Orientation'})
```

<!--{"pinCode":false,"dname":"6c906c33-d858-4855-9c3e-f16fe38c2acb","codeMode":"js"}-->
```js
Inputs.button('Plot Timeline', {reduce: ()=>{plotTimeline(datefield)}
})
```


<!--{"pinCode":false,"dname":"eda9828b-71b5-434c-99d4-efe637e701eb","codeMode":"js"}-->
```js
md `<div style="display: flex; justify-content:flex-end; font-size: 1.2em;">
  <a>${Link("1_userAnalysis.md", "Overview")} </a>
</div>`
```


<!--{"pinCode":false,"dname":"2e3c10a3-c496-4ec3-b619-6aa731328b51","codeMode":"js","hide":true}-->
```js
plotTimeline = async (datefield)=>{ 
  let max_y= 1
  let min_y=-1
  let y_spread = max_y - min_y
  let x_spread = 2*y_spread

  await createDateNodes()
  
//   use __gxr_date__ field so we can plot timeline in both directions
  gxr.nodes()
    .filter(n=>n.properties[datefield])
    .forEach(n=>n.properties.__gxr_date__ = Date.parse(n.properties[datefield]) * (orientation == 'up' ? -1 : 1))
  
  await gxr.sleep(300)
  gxr.nodes()
    .filter(n=>n.properties[datefield])
    .forEach(n=>{
      n.position.x = 0
      n.position.y = 0
  })
  await gxr.sleep(300)

  gxr.nodes()
    .filter(n=>n.properties[datefield])
    .distributionBy({
    dimension: 'x',
    bin: datefield,
    binType: 'date',
    spread: x_spread,
  })

  await gxr.sleep(200)
  gxr.nodes()
    .filter(n=>n.properties[datefield])
    .distributionBy({
    dimension: 'y',
    bin: '__gxr_date__',
//     bin: datefield,
//     binType: 'date',
    reverse: true,
    spread: y_spread,
  })
  await gxr.sleep(200)
  gxr.nodes()
    .filter(n=>n.properties[datefield])
    .distributionBy({
    dimension: 'y',
    spread: y_spread,
  })

  await gxr.sleep(200)

  gxr.nodes({category:'Date'})
    .filter(n=>n.properties.location==1)
    .forEach(n=>n.position.y = max_y+0.2)
  
  gxr.nodes({category:'Date'})
    .filter(n=>n.properties.location==-1)
    .forEach(n=>n.position.y = min_y-0.1)  
  
//   gxr.nodes({category:'Game'})
// //     .filter(n=>n.properties.location==-1)
//     .forEach(n=>n.position.y = max_y+0.1)  
  
  await gxr.sleep(300)
  gxr.nodes()
    .filter(n=>n.properties.__gxr_date__)
    .forEach(n=>{delete n.properties.__gxr_date__})

}
```

<!--{"pinCode":false,"dname":"e30e4861-90dd-46f2-a976-c813ba05366d","codeMode":"js","hide":true}-->
```js
getDateStrings = (raw_dates, max_ticks = 10) => {
  if (!raw_dates || !raw_dates.length) return [];

  // Accept Date or ISO string with microseconds
  const normalizeIso = s => typeof s === "string"
    ? s.replace(/(\.\d{3})\d+$/, "$1")
    : s;
  const toDate = v => v instanceof Date ? v : new Date(normalizeIso(v));
  const parsed = raw_dates.map(toDate).filter(d => !isNaN(d));
  if (!parsed.length) return [];

  const min = new Date(Math.min(...parsed.map(d => +d)));
  const max = new Date(Math.max(...parsed.map(d => +d)));
  if (+min === +max) return [formatDateTime(min)]; // single point

  const diffMs = max - min;
  const diffH = diffMs / 36e5;
  const diffD = diffH / 24;

  // Formatters
  function pad(n){ return String(n).padStart(2,"0"); }
  function formatDate(d){
    return `${d.getFullYear()}-${pad(d.getMonth()+1)}-${pad(d.getDate())}`;
  }
  function formatDateTime(d){
    return `${formatDate(d)}T${pad(d.getHours())}:${pad(d.getMinutes())}`;
  }

  // Choose interval & formatter
  let interval, totalUnits, useDateOnly;
  if (diffD >= 3) {
    // Many days: date-only labels, day-based ticks
    useDateOnly = true;
    interval = d3.timeDay;
    totalUnits = Math.max(1, Math.round(diffMs / 86400000)); // days
  } else if (diffH >= 3) {
    // < 3 days: hour ticks, show time
    useDateOnly = false;
    interval = d3.timeHour;
    totalUnits = Math.max(1, Math.round(diffMs / 36e5)); // hours
  } else {
    // < 3 hours: minute ticks, show time
    useDateOnly = false;
    interval = d3.timeMinute;
    totalUnits = Math.max(1, Math.round(diffMs / 60000)); // minutes
  }

  // Pick a step so we aim for <= max_ticks
  const step = Math.max(1, Math.ceil(totalUnits / max_ticks));
  const it = interval.every(step);

  // Build ticks aligned to interval boundaries
  let ticks = it.range(interval.floor(min), max);

  // Ensure we have at least one tick and include the end if aligned
  if (!ticks.length) ticks = [interval.floor(min), interval.floor(max)];
  else {
    const last = interval.floor(max);
    if (+ticks[ticks.length - 1] !== +last && +last > +ticks[ticks.length - 1]) {
      ticks.push(last);
    }
  }

  // Hard cap to max_ticks (downsample)
  if (ticks.length > max_ticks) {
    const stride = Math.ceil(ticks.length / max_ticks);
    ticks = ticks.filter((_, i) => i % stride === 0);
    // make sure last tick aligns with end
    const last = interval.floor(max);
    if (+ticks[ticks.length - 1] !== +last) {
      ticks[ticks.length - 1] = last;
    }
  }

  return ticks.map(useDateOnly ? formatDate : formatDateTime);
};
```

<!--{"pinCode":false,"dname":"18f32932-5608-44f6-8157-c67814c7d85a","codeMode":"js","hide":true}-->
```js
createDateNodes = async ()=>
{
//   remove existing Date nodes()
  gxr.nodes({category:'Date'}).remove()
  await gxr.sleep(500)
  
  let raw_dates = gxr.nodes()
    .filter(n=>n.properties[datefield])
    .map(n=>n.properties[datefield])

  const dateStrings = getDateStrings(raw_dates)
//   return dateStrings

  let nodes_data_up= dateStrings.map(d=>{
    let prop = {}; prop[datefield]=d;
    return {id: d+'-up', category:'Date', properties:{...prop, location: 1}}
  })
  let nodes_data_down= dateStrings.map(d=>{
    let prop = {}; prop[datefield]=d;
    return {id: d+'-down', category:'Date', properties:{...prop, location: -1}}
  })

  let nodes_data = _.flatten([nodes_data_up, nodes_data_down])
  
  gxr.add(nodes_data)
  
  let edge_list = dateStrings.map(d=>{
    return {sourceId: d+'-down', targetId: d+'-up'}
  })
  gxr.add(edge_list)
  gxr.dispatchGraphDataUpdate();
  return edge_list
  
}
```

<!--{"pinCode":false,"dname":"b181e914-d82e-4777-8a7b-ac6d65fa1cdf","codeMode":"js","hide":true}-->
```js
md `### Appendix`
```

<!--{"pinCode":false,"dname":"43c6efac-6f9b-436c-84eb-72f65cb14761","codeMode":"js","hide":true}-->
```js
API=_app.controller.API
```

<!--{"pinCode":false,"dname":"2482842d-c4db-4a55-963b-e62ba3f8b10d","codeMode":"js","hide":true}-->
```js
function debounce(input, delay = 1000) {
  return Generators.observe(notify => {
    let timer = null;
    let value;

    // On input, check if we recently reported a value.
    // If we did, do nothing and wait for a delay;
    // otherwise, report the current value and set a timeout.
    function inputted() {
      if (timer !== null) return;
      notify(value = input.value);
      timer = setTimeout(delayed, delay);
    }

    // After a delay, check if the last-reported value is the current value.
    // If it’s not, report the new value.
    function delayed() {
      timer = null;
      if (value === input.value) return;
      notify(value = input.value);
    }

    input.addEventListener("input", inputted), inputted();
    return () => input.removeEventListener("input", inputted);
  });
}
```
