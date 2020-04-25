# Dynamodb
## Auto scaling
 - schedule auto scaling:

scenario: want to increase write capacity at specific time before running some task has high write load,  because behavior of aws dynamodb scaling not scale immediately when provision pass.
```
        aws application-autoscaling put-scheduled-action --service-namespace dynamodb \
        --scalable-dimension dynamodb:table:WriteCapacityUnits \
        --resource-id table/<table_name> \
        --scheduled-action-name my-recurring-action \
        --schedule "cron(57 23 * * ? *)" \
        --scalable-target-action MinCapacity=<min>,MaxCapacity=<max>
 ```
  * notes:
  - it may run after schedule time 5 minutes