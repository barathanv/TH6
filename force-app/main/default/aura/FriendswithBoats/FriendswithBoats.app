<aura:application extends="force:slds"  >
    <lightning:layout>
        <lightning:layoutitem flexibility="grow">
    	<div class="slds-grid slds-gutters">
          <div class="slds-col slds-size_4-of-6">
            <c:BoatSearch/>
          </div>
          <div class="slds-col slds-size_2-of-6">
              <c:BoatDetails/>
          </div>
    	</div>
        </lightning:layoutitem>
      </lightning:layout>
</aura:application>