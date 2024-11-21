-- Working with the BellaBeat dataset
-- Getting Avg daily steps, calories,distance
SELECT 
DATE(ActivityDate) AS date,
AVG(TotalSteps) AS avg_daily_steps,
AVG(TotalDistance) AS avg_daily_distance,
AVG(Calories) AS avg_daily_calories
 FROM `striking-gadget-215217.BellaBeat.daily_activity`
 GROUP BY
  date
 ORDER BY date;

-- Using Joins to understand trends and usage
SELECT
cal.Id,
cal.calories AS total_calories,
 ROUND((
        AVG(intensities.FairlyActiveMinutes) +
        AVG(intensities.LightlyActiveMinutes) +
        AVG(intensities.VeryActiveMinutes) +
        AVG(intensities.SedentaryMinutes)
    ) / 4, 2) AS avg_intensity,
 steps.StepTotal,
    sleep.TotalMinutesAsleep,
    weight.WeightKg
    FROM `striking-gadget-215217.BellaBeat.daily_calories` AS cal
    LEFT JOIN 
    `striking-gadget-215217.BellaBeat.daily_intensities` AS intensities
    ON
    cal.Id= intensities.Id
    LEFT JOIN
    `striking-gadget-215217.BellaBeat.daily_steps` AS steps
    ON
    cal.Id=steps.Id
    LEFT JOIN
    `striking-gadget-215217.BellaBeat.sleep_day` AS sleep
    ON
    cal.Id=sleep.Id
    LEFT JOIN
    `striking-gadget-215217.BellaBeat.weightlog_info` AS weight
    ON
    cal.Id= weight.Id
    GROUP BY
    cal.Id, total_calories, steps.StepTotal, sleep.TotalMinutesAsleep, weight.WeightKg
ORDER BY
    total_calories DESC;


