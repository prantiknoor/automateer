import express from "express"
import morgan from "morgan"
import { performTasks } from "./script.mjs"

const app = express()

app.use(morgan('dev'))
app.use(express.json())

app.post('/run', async (req, res) => {
  const outputs = await performTasks(req.body)
  res.status(200).json(outputs)
})

app.listen(3000, () => console.log("Listening on port 3000..."));