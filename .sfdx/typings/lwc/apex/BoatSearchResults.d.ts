declare module "@salesforce/apex/BoatSearchResults.getBoatTypes" {
  export default function getBoatTypes(): Promise<any>;
}
declare module "@salesforce/apex/BoatSearchResults.getBoats" {
  export default function getBoats(param: {boatTypeId: any}): Promise<any>;
}
