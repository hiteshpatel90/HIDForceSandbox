global class BatchSchedulerTrainingExp implements Schedulable {
    global void execute(SchedulableContext scMain){
        BatchUpdateTraining batchit = new BatchUpdateTraining();
        ID idBatch = Database.executeBatch(batchit);
        
    }

}