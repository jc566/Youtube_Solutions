using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Shoot : MonoBehaviour {
	
	public GameObject projectile; //reference to the Capsule aka PlayerProjectile

	public Transform projectileSpawn; //reference to where the projectile will spawn from...

	public float nextFire = 1.0f; //time interval between shots
	public float currentTime = 0.0f; //current time to build up

	// Use this for initialization
	void Start () {
		projectileSpawn = this.gameObject.transform; //make link to where this game object is
	}
	
	// Update is called once per frame
	void Update () {
		
		shoot (); //SHOOOOOOOOOOOOOOOOT!!!!!!!!!!!
	}

	//this function allows for projectiles to shoot up aka forward of the ship
	public void shoot()
	{
		currentTime += Time.deltaTime; //build the timer up for current time
		if(Input.GetButton("Fire1") && currentTime > nextFire) //if player hits Fire and Current time is greater then the interval between...
		{
			nextFire += currentTime; //add the current time to next fire, so you cant shoot again

			Instantiate (projectile,projectileSpawn.position, Quaternion.identity); //shoot!!!

			nextFire -= currentTime; //subtract the current time from next fire, so we can "reset" interval to 1
			currentTime = 0.0f; //reset current time
		}
	}
}
