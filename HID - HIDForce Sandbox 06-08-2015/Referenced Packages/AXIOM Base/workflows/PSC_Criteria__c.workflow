<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>ResetStatus</fullName>
        <description>Set Status to NULL in case there are no data specified in object fields</description>
        <field>Status__c</field>
        <name>Reset Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SetStatus</fullName>
        <field>Status__c</field>
        <literalValue>none</literalValue>
        <name>Set Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Criterion Is Empty</fullName>
        <actions>
            <name>ResetStatus</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PSC_Criteria__c.Impact1__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>PSC_Criteria__c.Evidence__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>PSC_Criteria__c.Criterion__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Criterion Is Filled Out</fullName>
        <actions>
            <name>SetStatus</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(   ISBLANK(PRIORVALUE(Status__c )),      OR(       NOT(ISBLANK( Impact1__c )),     NOT(ISBLANK( Evidence__c )),     NOT(ISBLANK( Criterion__c ))   ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
