package com.utility;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.service.ServiceRegistryBuilder;

public class Connection {
	private static SessionFactory sessionFactory;
	private static SessionFactory localsessionFactory;

	public static SessionFactory getSessionFactory() {
		if (sessionFactory == null) {
			Configuration configuration = new Configuration().configure();
			ServiceRegistryBuilder registry = new ServiceRegistryBuilder();
			registry.applySettings(configuration.getProperties());
			ServiceRegistry serviceRegistry = registry.buildServiceRegistry();
			sessionFactory = configuration.buildSessionFactory(serviceRegistry);
		}
		return sessionFactory;
	}

	// public static SessionFactory getSessionFactoryLocal(){
	// if (localsessionFactory == null) {
	// Configuration configuration = new
	// Configuration().configure("/hibernateLocal.xml");
	// ServiceRegistryBuilder registry = new ServiceRegistryBuilder();
	// registry.applySettings(configuration.getProperties());
	// ServiceRegistry serviceRegistry = registry.buildServiceRegistry();
	// sessionFactory = configuration.buildSessionFactory(serviceRegistry);
	// }
	// return localsessionFactory;
	// }
}
