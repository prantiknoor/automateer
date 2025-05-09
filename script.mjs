import puppeteer from "puppeteer";
// import tasks from "./tasks.json" assert { type: "json" };

const browser = await puppeteer.launch({ args: ["--no-sandbox"] })

export async function performTasks(tasks) {
  const outputs = {};
  // const page = (await browser.pages()).at(0)
  const page = await browser.newPage()

  for (let i = 0; i < tasks.length; i++) {
    const { id, name, method, params = {}, include } = tasks[i]
    console.time(name)

    if (params['pageFunction']) {
      params['pageFunction'] = new Function(`return (${params['pageFunction']})`)()
    }

    const output = await page[method](...Object.values(params))
    // console.log(output)
    if (include) { outputs[id] = output }

    console.timeEnd(name)
  }
  page.close()

  return outputs
}

// for (let i = 0; i < 1; i++) {
//   performTasks(tasks).then(console.log)
// }

