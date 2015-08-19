<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_By_User</fullName>
        <field>Updated_by_User__c</field>
        <literalValue>1</literalValue>
        <name>Update By User</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Modified By User</fullName>
        <actions>
            <name>Update_By_User</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>!ISNEW() &amp;&amp; !ISCHANGED(Updated_by_User__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
