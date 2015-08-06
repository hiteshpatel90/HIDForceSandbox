<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Populate_Previous_Amount</fullName>
        <field>AXIOM_BASE__Previous_Amount__c</field>
        <formula>PRIORVALUE(AXIOM_BASE__Amount__c)</formula>
        <name>Populate Previous Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Previous_Win</fullName>
        <field>AXIOM_BASE__Previous_Win__c</field>
        <formula>PRIORVALUE(AXIOM_BASE__Probability_of_Win_Percent__c)</formula>
        <name>Populate Previous Win</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Date_Moved</fullName>
        <field>AXIOM_BASE__Date_Moved_Into_Stage__c</field>
        <formula>TODAY()</formula>
        <name>Update Date Moved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Populate Days In Stage %28SI%29</fullName>
        <actions>
            <name>Update_Date_Moved</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(ISNEW(), PRIORVALUE(AXIOM_BASE__Stage_Value__c ) &lt;&gt; AXIOM_BASE__Stage_Value__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Previous Amount %28SI%29</fullName>
        <actions>
            <name>Populate_Previous_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(NOT(ISNEW()), PRIORVALUE( AXIOM_BASE__Amount__c) &lt;&gt; AXIOM_BASE__Amount__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Previous Win %28SI%29</fullName>
        <actions>
            <name>Populate_Previous_Win</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(NOT(ISNEW()), PRIORVALUE( AXIOM_BASE__Probability_of_Win_Percent__c ) &lt;&gt; AXIOM_BASE__Probability_of_Win_Percent__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
