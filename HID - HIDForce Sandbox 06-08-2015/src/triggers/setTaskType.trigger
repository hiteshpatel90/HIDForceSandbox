trigger setTaskType on Task (before insert) {
	for(Task t : trigger.new){
		try{
			if(t.Subject.startsWith('Email:') && t.Description.startsWith('Additional To:')){
				t.Type = 'Email';
			}
		}catch(Exception e){}
	}
}