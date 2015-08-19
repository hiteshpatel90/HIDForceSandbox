trigger CaseFileAttach on Case (after insert)
{
	List<Case> cases = CaseFileAttachService.getCasesToAttachFile(Trigger.new);
	CaseFileAttachService.attachFile(cases);
}